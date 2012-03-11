
module FlashPlayer
  NAME    = 'flashplayer'
  VERSION = '10.3.183'

  class << self

    def home
      # NOTE: Look up the value every time,
      # this way we're not storing state globally
      # and the performance penalty is minimal...
      home_paths.each do |path|
        return path if File.exists?(path)
      end
      raise FlashPlayer::PathError.new('FlashPlayer unable to find home folder for your System')
    end

    def trust
      File.join home, '#Security', 'FlashPlayerTrust', 'sprout.cfg'
    end

    def flashlog
      File.join home, 'Logs', 'flashlog.txt'
    end

    private

    def system_home
      Sprout.current_system.home
    end

    def system_library
      Sprout.current_system.library
    end

    # Collection of the potential locations of the Flash Player Home
    # For each supported Platform, the first existing location
    # will be used.
    def home_paths
      [
        File.join(system_library, 'Preferences', 'Macromedia', 'Flash Player'),
        File.join(system_library, 'Application Support', 'Macromedia'),
        File.join(system_home, 'Application Data', 'Macromedia', 'Flash Player'),
        File.join(system_home, 'AppData', 'Roaming', 'Macromedia', 'Flash Player'),
        File.join(system_home, '.macromedia', 'Flash_Player')
      ]
    end

  end
end

