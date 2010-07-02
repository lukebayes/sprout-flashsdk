
=begin

  class FlashPlayerTask < Rake::Task
    # This is the opening prelude to a collection of test results. When the
    # task encounters this string in the trace output log file, it will begin
    # collecting trace statements with the expectation that the following
    # strings will be well-formatted XML data matching what JUnit emits for 
    # Cruise Control.
    #
    # See the lib/asunit3/asunit.framework.XMLResultPrinter for more information.
    @@test_result_pre_delimiter = '<XMLResultPrinter>'

    # This is the closing string that will indicate the end of test result XML data
    @@test_result_post_delimiter = '</XMLResultPrinter>'

    @@home = nil
    @@trust = nil

    def initialize(task_name, app)
      super(task_name, app)
      @default_gem_name = 'sprout-flashplayer-tool'
      @default_gem_version = '10.22.0'
      @default_result_file = 'AsUnitResults.xml'
      @inside_test_result = false
    end

    def self.define_task(args, &block)
      t = super
      yield t if block_given?
      t.define
    end
    
    # Local system path to the Flash Player Trust file
    def FlashPlayerTask.trust
      if(@@trust)
        return @@trust
      end
      @@trust = File.join(FlashPlayerTask.home, '#Security', 'FlashPlayerTrust', 'sprout.cfg')
      return @@trust
    end

    # Local system path to where the Flash Player stores trace output logs and trust files
    def FlashPlayerTask.home
      if(@@home)
        return @@home
      end

      FlashPlayerTask.home_paths.each do |path|
        if(File.exists?(path))
          return @@home = path
        end
      end

      if(@@home.nil?)
        raise FlashPlayerError.new('FlashPlayer unable to find home folder for your platform')
      end
      return @@home
    end

    # Collection of the potential locations of the Flash Player Home
    # For each supported Platform, the first existing location
    # will be used.
    def FlashPlayerTask.home_paths
      return [File.join(User.library, 'Preferences', 'Macromedia', 'Flash Player'),
              File.join(User.library, 'Application Support', 'Macromedia'),
              File.join(User.home, 'Application Data', 'Macromedia', 'Flash Player'),
              File.join(User.home, 'AppData', 'Roaming', 'Macromedia', 'Flash Player'),
              File.join(User.home, '.macromedia', 'Flash_Player')]
    end

    # The swf parameter can be set explicitly in the block sent to this task as in:
    #   
    #   flashplayer :run do |t|
    #     t.swf = 'bin/SomeProject.swf'
    #   end
    #
    # Or it can be set implicitly as a rake prerequisite as follows:
    #
    #   flashplayer :run => 'bin/SomeProject' do |t|
    #   end
    #
    def swf=(swf)
      @swf = swf
    end

    def swf
      @swf ||= nil
      if(@swf.nil?)
        prerequisites.each do |req|
          if(req.index('.swf'))
            @swf = req.to_s
            break
          end
        end
      end
      return @swf
    end

    def gem_version=(version)
      @gem_version = version
    end
    
    def gem_version
      return @gem_version ||= nil
    end
    
    # Full name of the sprout tool gem that this tool task will use. 
    # This defaults to sprout-flashplayer-tool
    def gem_name=(name)
      @gem_name = name
    end

    def gem_name
      return @gem_name ||= @default_gem_name
    end
    
    # The File where JUnit test results should be written. This value
    # defaults to 'AsUnitResults.xml'
    #
    def test_result_file=(file)
      @test_result_file = file
    end

    def test_result_file
      @test_result_file ||= @default_result_file
    end
    
    def test_result
      @test_result ||= ''
    end

    def define # :nodoc:
      CLEAN.add(test_result_file)
    end

    def execute(*args)
      super
      raise FlashPlayerError.new("FlashPlayer task #{name} required field swf is nil") unless swf
      
      log_file = nil

      # Don't let trust or log file failures break other features...
      begin
        config = FlashPlayerConfig.new
        log_file = config.log_file
        FlashPlayerTrust.new(File.expand_path(File.dirname(swf)))

        if(File.exists?(log_file))
          File.open(log_file, 'w') do |f|
            f.write('')
          end
        else
          FileUtils.makedirs(File.dirname(log_file))
          FileUtils.touch(log_file)
        end
      rescue StandardError => e
        logger.puts '[WARNING] FlashPlayer encountered an error working with the mm.cfg log and/or editing the Trust file'
      end
      
      @running_process = nil
      @thread = run(gem_name, gem_version, swf)
      read_log(@thread, log_file) unless log_file.nil?
      @thread.join
    end

    def run(tool, gem_version, swf)
      path_to_exe = Sprout.get_executable(tool, nil, gem_version)
      target = User.clean_path(path_to_exe)
      @player_pid = nil
      
      thread_out = $stdout
      command = "#{target} #{User.clean_path(swf)}"

      usr = User.new()
      if(usr.is_a?(WinUser) && !usr.is_a?(CygwinUser))
        return Thread.new {
            system command
        }
      elsif usr.is_a?(OSXUser)
        require 'clix_flash_player'
        @clix_player = CLIXFlashPlayer.new
        @clix_player.execute(target, swf)
        return @clix_player
      else
        return Thread.new {
          require 'open4'
          @player_pid, stdin, stdout, stderr = Open4.popen4(command)
          stdout.read
        }
      end
    end
    
    def close
      usr = User.new
      if(usr.is_a?(WinUser))
        Thread.kill(@thread)
      elsif(usr.is_a?(OSXUser))
        @clix_player.kill unless @clix_player.nil?
      else
        Process.kill("SIGALRM", @player_pid)
      end
    end
    
    def read_log(thread, log_file)
      lines_put = 0

      if(log_file.nil?)
        raise FlashPlayerError.new('[ERROR] Unable to find the trace output log file because the expected location was nil')
      end

      if(!File.exists?(log_file))
        raise FlashPlayerError.new('[ERROR] Unable to find the trace output log file in the expected location: ' + log_file)
      end

      while(thread.alive?)
        sleep(0.2)
        lines_read = 0

        File.open(log_file, 'r') do |file|
          file.readlines.each do |line|
            lines_read = lines_read + 1
            if(lines_read > lines_put)
              if(!parse_test_result(line, thread))
                logger.puts "[trace] #{line}"
              end
              $stdout.flush
              lines_put = lines_put + 1
            end
          end
        end
      end
    end

    # Returns true if inside of a test result
    def parse_test_result(line, thread)
      if(@inside_test_result)
        if(line.index(@@test_result_post_delimiter))
          @inside_test_result = false
          write_test_result(test_result)
          close
          examine_test_result test_result
          return true
        else
          test_result << line
        end
      end

      if(line.index(@@test_result_pre_delimiter))
        @inside_test_result = true
      end
      
      return @inside_test_result
    end
    
    def write_test_result(result)
      FileUtils.makedirs(File.dirname(test_result_file))
      File.open(test_result_file, File::CREAT|File::TRUNC|File::RDWR) do |f|
        f.puts(result)
      end
    end

    def examine_test_result(result)
      require 'rexml/document'
      doc = nil
      begin
        doc = REXML::Document.new(result)
      rescue REXML::ParseException => e
        puts "[WARNING] Invalid test results encountered"
        return
      end
      
      # Handle JUnit Failures
      failures = []

      doc.elements.each('/testsuites/testsuite/testsuite/testcase/error') do |element|
        failures << element.text
      end

      doc.elements.each("/testsuites/testsuite/testsuite/testcase/failure") do |element|
        failures << element.text
      end

      if(failures.size > 0)
        raise AssertionFailure.new("[ERROR] Test Failures Encountered \n#{failures.join("\n")}")
      end
    end

  end

=end


