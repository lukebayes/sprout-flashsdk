require 'test_helper'

class FlashPlayerTest < Test::Unit::TestCase
  include SproutTestCase

  context "The FlashPlayer module" do

    context "should find home" do

      setup do
        @fixture = File.join(fixtures, 'home')

        @osx_home1 = File.join(@fixture, 'Preferences', 'Macromedia', 'Flash Player')
        @osx_home2 = File.join(@fixture, 'Application Support', 'Macromedia')
        @win_home1 = File.join(@fixture, 'Application Data', 'Macromedia', 'Flash Player')
        @win_home2 = File.join(@fixture, 'AppData', 'Roaming', 'Macromedia', 'Flash Player')
        @nix_home1 = File.join(@fixture, '.macromedia', 'Flash_Player')

        # Ensure the looks in our Fixtures folder instead of system:
        FlashPlayer.stubs(:system_library).returns @fixture
        FlashPlayer.stubs(:system_home).returns @fixture
      end

      teardown do
        remove_file File.join(@fixture)
      end

      should "find home on osx" do
        FileUtils.mkdir_p @osx_home1
        assert_equal @osx_home1, FlashPlayer.home
      end

      should "find home on osx 2" do
        FileUtils.mkdir_p @osx_home2
        assert_equal @osx_home2, FlashPlayer.home
      end

      should "find home on win 1" do
        FileUtils.mkdir_p @win_home1
        assert_equal @win_home1, FlashPlayer.home
      end

      should "find home on win 2" do
        FileUtils.mkdir_p @win_home2
        assert_equal @win_home2, FlashPlayer.home
      end

      should "find home on nix 1" do
        FileUtils.mkdir_p @nix_home1
        assert_equal @nix_home1, FlashPlayer.home
      end
    end

  end
end

