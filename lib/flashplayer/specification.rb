require 'flashsdk'

Sprout::Specification.new do |s|
  s.name        = 'flashplayer'
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
    t.md5          = "1f5e411f96817b56c99111a06f4c727f"
    t.add_executable :flashplayer, "1f5e411f96817b56c99111a06f4c727f.exe"
  end

  s.add_remote_file_target do |t|
    t.platform     = :osx
    t.archive_type = :zip
    t.url          = "http://download.macromedia.com/pub/flashplayer/updaters/10/flashplayer_10_sa_debug.app.zip"
    t.md5          = "1c5ef8aeb1aa4a6cee7970d5c7ee9a55"
    t.add_executable :flashplayer, "Flash Player Debugger.app"
  end

  s.add_remote_file_target do |t|
    t.platform     = :linux
    t.archive_type = :tgz
    t.url          = "http://download.macromedia.com/pub/flashplayer/updaters/10/flashplayer_10_sa_debug.tar.gz"
    t.md5          = "1efa254bc7d6e0c11a61984ae34bfaa7"
    t.add_executable :flashplayer, "flashplayerdebugger"
  end
end

