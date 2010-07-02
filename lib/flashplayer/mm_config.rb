
module FlashPlayer

  class MMConfig
    FILE_NAME = 'mm.cfg'

    attr_accessor :logger

    def initialize
      @file_name = FILE_NAME
      @logger    = $stdout
    end

    def create
      create_if_necessary_at config_path
    end

    private

    def create_if_necessary_at path
      if(File.exists?(File.dirname(path)))
        write_config(path, content(flashlog_path)) if(file_blank?(path))
      end
    end

    def config_path
      if(flashplayer_home == osx_fp9_dir)
        path = File.join(osx_fp9_dir, @file_name)
      else
        path = File.join(system_home, @file_name)
      end
    end

    def flashplayer_home
      FlashPlayer.home
    end

    def flashlog_path
      FlashPlayer.flashlog
    end

    def file_blank?(file)
      !File.exists?(file) || File.read(file).empty?
    end

    def write_config(location, content)
      if(user_confirmation?(location))
        FileUtils.makedirs File.dirname(location)

        File.open(location, 'w') do |f|
          f.write(content)
        end
        logger.puts ">> Created file: " + File.expand_path(location)
        location
      else
        raise FlashPlayer::PathError.new("Unable to create #{location}")
      end
    end

    def content(flashlog)
      return <<EOF
ErrorReportingEnable=1
MaxWarnings=0
TraceOutputEnable=1
TraceOutputFileName=#{flashlog}
EOF
    end

    def user_confirmation?(location)
      puts <<EOF

Correctly configured mm.cfg file not found at: #{location}

This file is required in order to capture trace output.

Would you like this file created automatically? [Yn]

EOF
      answer = $stdin.gets.chomp.downcase
      return (answer == 'y' || answer == '')
    end

    def osx_fp9_dir
      File.join(system_library, 'Application Support', 'Macromedia')
    end

    def system_library
      Sprout.current_system.library
    end

    def system_home
      Sprout.current_system.home
    end
  end
end

