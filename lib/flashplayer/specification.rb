require 'flashsdk'

Sprout::Specification.new do |s|
  s.name        = FlashPlayer::NAME
  s.version     = FlashSDK::VERSION

  s.add_remote_file_target do |t|
    t.platform     = :osx
    t.archive_type = :zip
    t.url          = "http://download.macromedia.com/pub/flashplayer/updaters/10/flashplayer_10_sa_debug.app.zip"
    t.md5          = "1c5ef8aeb1aa4a6cee7970d5c7ee9a55"
    t.add_executable :flashplayer, "Flash Player Debugger.app"
  end

  s.add_remote_file_target do |t|
    t.platform     = :win32
    t.archive_type = :exe
    t.url          = "http://download.macromedia.com/pub/flashplayer/updaters/10/flashplayer_10_sa_debug.exe"
    t.md5            "1f5e411f96817b56c99111a06f4c727f"
    t.add_executable :flashplayer, "flashplayer_10_sa_debug.exe"
  end

  s.add_remote_file_target do |t|
    t.platform     = :linux
    t.archive_type = :tgz
    t.url          = "http://download.macromedia.com/pub/flashplayer/updaters/10/flashplayer_10_sa_debug.tar.gz"
    t.md5          = "1efa254bc7d6e0c11a61984ae34bfaa7"
    t.add_executable :flashplayer, "flashplayerdebugger"
  end

end

