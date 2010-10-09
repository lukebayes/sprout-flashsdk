require File.join(File.dirname(__FILE__), 'test_helper')

class MMConfigTest < Test::Unit::TestCase
  include SproutTestCase

  context "An MMConfig" do

    setup do
      @home = File.join(fixtures, 'home')
      @osx_fp  = File.join(@home, 'Application Support', 'Macromedia')
      @linux_fp = File.join(@home, '.macromedia', 'Flash_Player')

      FileUtils.mkdir_p @home

      @mm_config = FlashPlayer::MMConfig.new
      @mm_config.stubs(:user_confirmation?).returns true
      @mm_config.logger = StringIO.new
    end

    teardown do
      remove_file @home
    end

    should "ignore failure if flashplayer has never run" do
      # No creation of expected FlashPlayer folders...
      
      as_a_mac_system do
        @mm_config.stubs(:system_library).returns @home
        @mm_config.stubs(:flashplayer_home).returns @osx_fp
        @mm_config.create
      end
    end

    should "create a config file on OS X with FP 9" do
      FileUtils.mkdir_p @osx_fp
      flashlog = File.expand_path(File.join(@osx_fp, 'Logs', 'flashlog.txt'))

      as_a_mac_system do
        @mm_config.stubs(:system_library).returns @home
        @mm_config.stubs(:flashplayer_home).returns @osx_fp
        @mm_config.stubs(:flashlog_path).returns flashlog
        @mm_config.create
        mm_cfg = File.join(@osx_fp, mm_config_file)
        assert_file mm_cfg do |content|
          assert_matches /#{@flashlog}/, content
        end
      end
    end

    should "create a config file on linux" do
      FileUtils.mkdir_p @linux_fp
      flashlog = File.expand_path(File.join(@linux_fp, 'Logs', 'flashlog.txt'))

      as_a_unix_system do
        @mm_config.stubs(:system_library).returns @home
        @mm_config.stubs(:system_home).returns @home
        @mm_config.stubs(:flashlog_path).returns flashlog
        @mm_config.stubs(:flashplayer_home).returns @linux_fp
        @mm_config.create
        mm_cfg = File.join(@home, mm_config_file)
        assert_file mm_cfg do |content|
          assert_matches /#{flashlog}/, content
        end
      end
    end
  end

  private

  def mm_config_file
    FlashPlayer::MMConfig::FILE_NAME
  end
end

