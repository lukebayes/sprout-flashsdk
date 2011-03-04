
module FlashPlayer

  class Executable < Sprout::Executable::Base

    ##
    # The file that the Flash Player should launch.
    #
    #   flashplayer bin/SomeProject.swf
    #
    add_param :input, String, { :hidden_name => true, :required => true }

    ##
    # Drop into FDB after launching the Player.
    #
    #   flashplayer --fdb bin/SomeProject.swf
    #
    add_param :fdb, Boolean, { :hidden_value => true }

    def initialize
      super
      @mm_config    = MMConfig.new
      @reader       = LogFile.new
      @trust_config = Trust.new
      @process      = nil
      @stdout       = $stdout
      @stderr       = $stderr
      @logger       = $stdout

      @pkg_name     = FlashPlayer::NAME
      @pkg_version  = FlashPlayer::VERSION
    end

    def execute *args
      execute_safely do
        update_mm_config
        update_trust_config_with input
      end

      if use_fdb?
        launch_fdb_and_player_with input
      else
        player_thread = launch_player_with input
        tail_flashlog player_thread
      end
    end

    def use_fdb?
      # Check as string b/c this is
      # how the boolean value comes
      # accross the command line input.
      fdb || ENV['USE_FDB'].to_s == 'true'
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

    def launch_fdb_and_player_with input
      # Keep getting a fatal lock error which I believe
      # is being caused by the FlashPlayer and FDB attempting
      # to write to stdout simultaneously.
      # Trying to give fdb a fake stream until after the
      # player is launched...
      fake_out = Sprout::OutputBuffer.new
      fake_err = Sprout::OutputBuffer.new

      fdb_instance = FlashSDK::FDB.new
      fdb_instance.stdout = fake_out
      fdb_instance.stderr = fake_err
      fdb_instance.execute false
      fdb_instance.run
      player_thread = launch_player_with input

      # Emit whatever messages have been passed:
      stdout.puts fake_out.read
      stdout.flush
      stderr.puts fake_err.read
      stdout.flush
      # Replace the fdb instance streams with
      # the real ones:
      fdb_instance.stdout = stdout
      fdb_instance.stderr = stderr

      # Let the user interact with fdb:
      fdb_instance.handle_user_input

      fdb_instance.wait
      player_thread.join if player_thread.alive?
    end

    def execute_safely
      begin
        Thread.abort_on_exception = true
        yield if block_given?
      rescue FlashPlayer::PathError => e
        logger.puts ">> [WARNING] It seems this was the first time FlashPlayer was launched on this system and as a result, the expected folders were not found. Please close the Player and run again - this message should only ever be displayed once."
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
      current_system.open_flashplayer_with player, clean_path(swf)
    end

    def tail_flashlog player_thread
      @reader.tail player_thread
    end

  end
end

