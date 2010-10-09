require 'flashsdk'

Sprout::Specification.new do |s|
  s.name        = FlashPlayer::NAME
  s.version     = FlashSDK::VERSION

  s.add_remote_file_target do |t|
    t.platform     = :osx
    t.archive_type = :zip
    t.url          = "http://download.macromedia.com/pub/flashplayer/updaters/10/flashplayer_10_sa_debug.app.zip"
    t.md5          = "ff6824b7fd676dd1b613204221f5b5b9"
    t.add_executable :flashplayer, "Flash Player Debugger.app"
  end

  s.add_remote_file_target do |t|
    t.platform     = :win32
    t.archive_type = :exe
    t.url          = "http://download.macromedia.com/pub/flashplayer/updaters/10/flashplayer_10_sa_debug.exe"
    t.md5          = "4d8d58d72709f44421b2ea4e89cc30be"
    t.add_executable :flashplayer, "flashplayer_10_sa_debug.exe"
  end

  s.add_remote_file_target do |t|
    t.platform     = :linux
    t.archive_type = :tgz
    t.url          = "http://download.macromedia.com/pub/flashplayer/updaters/10/flashplayer_10_sa_debug.tar.gz"
    t.md5          = "6cabe6038343374b547043d29de14417"
    t.add_executable :flashplayer, "flashplayerdebugger"
  end

end

