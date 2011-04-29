
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
      @input = task_name
      @player = FlashPlayer::Executable.new
      @pkg_name = FlashPlayer::NAME
      @pkg_version = FlashPlayer::VERSION
    end

    def execute *args
      super
      update_input_if_necessary
      @player.input = input
      @player.ci = use_ci?
      @player.fdb = use_fdb?
      @player.execute
    end

    def logger=(logger)
      @player.logger = logger
    end

    def logger
      @player.logger
    end

    private

    def use_ci?
      ENV['USE_CI'].to_s == 'true'
    end

    def use_fdb?
      # Check as string b/c this is
      # how the boolean value comes
      # accross the command line input.
      ENV['USE_FDB'].to_s == 'true'
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

  end
end

def flashplayer *args, &block
  FlashPlayer::Task.define_task *args, &block
end

