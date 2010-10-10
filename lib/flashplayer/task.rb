
module FlashPlayer

  class Task < Rake::Task

    attr_accessor :input
    attr_accessor :pkg_name
    attr_accessor :pkg_version

    ##
    # This is the Rake::Task constructor
    # signature...
    def initialize task_name, rake_application
      super
      @logger       = $stdout
      @mm_config    = MMConfig.new
      @reader       = LogFile.new
      @trust_config = Trust.new
      @process      = nil
      @input        = task_name

      @pkg_name     = FlashPlayer::NAME
      @pkg_version  = FlashSDK::VERSION
    end

    def execute *args
      super
      update_input_if_necessary
      execute_safely do
        update_mm_config
        update_trust_config_with input
      end
      player_thread = launch_player_with input
      tail_flashlog player_thread
    end

    def logger=(logger)
      @logger              = logger
      @mm_config.logger    = logger
      @reader.logger       = logger
      @trust_config.logger = logger
    end

    def logger
      @logger
    end

    private

    def execute_safely
      begin
        Thread.abort_on_exception = true
        yield if block_given?
      rescue FlashPlayer::PathError => e
        logger.puts ">> [WARNING] It seems this was the first time FlashPlayer was launched on this system and as a result, the expected folders were not found. Please close the Player and run again - this message should only ever be displayed once."
      end
    end

    def update_input_if_necessary
      return if input.match(/\.swf$/)
      prerequisites.each do |prereq|
        if(prereq.match(/\.swf$/))
          self.input = prereq
          return
        end
      end
    end

    def update_mm_config
      @mm_config.create
    end

    def update_trust_config_with swf
      @trust_config.add File.dirname(swf)
    end

    def clean_path path
      current_system.clean_path path
    end

    def current_system
      @current_system ||= Sprout.current_system
    end

    def launch_player_with swf
      player = Sprout::Executable.load(:flashplayer, pkg_name, pkg_version).path
      swf = clean_path swf
      current_system.open_flashplayer_with player, swf
    end

    def tail_flashlog player_thread
      @reader.tail player_thread
    end
  end
end

def flashplayer *args, &block
  FlashPlayer::Task.define_task *args, &block
end

