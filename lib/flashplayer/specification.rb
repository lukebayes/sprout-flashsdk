  require 'flashsdk'

  ##
  # This is the Flash Player Sprout::Specification and is how
  # we figure out from where to load the Flash Player for the
  # current user system.
  Sprout::Specification.new do |s|
    s.name        = FlashPlayer::NAME
    s.version     = FlashPlayer::VERSION

    ##
    # NOTE: The order of these declarations is important, the RubyFeature.load method
    # will search for the first match that is appropriate for the end user system.
    #
    # Current releases of the Ruby One-Click Installer for Windows actually
    # run on top of Mingw, and OSX is a *nix variant, which means that 
    # all System types (in Ruby at least) derive from UnixSystem. 
    #
    # This means that the Linux/Unix declaration will
    # match everyone, so it is effectively the same as ':universal'
    s.add_remote_file_target do |t|
      t.platform     = :windows
      t.archive_type = :exe
      t.url          = "http://download.macromedia.com/pub/flashplayer/updaters/10/flashplayer_10_sa_debug.exe"
      t.md5          = "6897ac6223a8a5d0e93135871ca001fe"
      t.add_executable :flashplayer, "5f7f4c4246784745b0e1b5593e9bc60f.exe"
    end

    s.add_remote_file_target do |t|
      t.platform     = :osx
      t.archive_type = :zip
      t.url          = "http://download.macromedia.com/pub/flashplayer/updaters/10/flashplayer_10_sa_debug.app.zip"
      t.md5          = "67ca9fd0c92fdb8f6c9d0fe4f4e690ec"
      t.add_executable :flashplayer, "Flash Player Debugger.app"
    end

    s.add_remote_file_target do |t|
      t.platform     = :linux
      t.archive_type = :tgz
      t.url          = "http://download.macromedia.com/pub/flashplayer/updaters/10/flashplayer_10_sa_debug.tar.gz"
      t.md5          = "696264267dcf3305b8e4706bb60238ad"
      t.add_executable :flashplayer, "flashplayerdebugger"
    end
  end

