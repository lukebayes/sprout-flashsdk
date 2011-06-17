require 'test_helper'
require 'fake_flashplayer_system'

class FlashPlayerExecutableTest < Test::Unit::TestCase
  include Sprout::TestHelper

  context "A FlashPlayer Executable" do

    setup do
      # Force reload of the Specification on each
      # test method b/c Sprout::TestHelper calls
      # Executable.clear_entities! but 'require'
      # only runs once per VM run...
      load 'flashplayer/specification.rb'
      @swf          = File.join(fixtures, 'flashplayer', 'AsUnit Runner.swf')
      @missing_home = File.join(fixtures, 'missing_folder')
      @config_path  = File.join(@missing_home, 'fp_config', 'mm.cfg')
      @used_fdb     = ENV['USE_FDB']

      #Sprout.stdout = $stdout
      #Sprout.stderr = $stderr
    end

    teardown do
      remove_file @missing_home
      remove_file 'TestResults.xml'
      ENV['USE_FDB'] = @used_fdb
    end

=begin
    should "launch SWF on os x" do
      # No creation of expected FlashPlayer folders...

      #FlashPlayer.stubs(:home).returns @missing_home
      #FlashPlayer::MMConfig.any_instance.stubs(:system_home).returns @missing_home
      #FlashPlayer::MMConfig.any_instance.stubs(:config_path).returns @config_path
      #FlashPlayer::MMConfig.any_instance.stubs(:user_confirmation?).returns false

      #ENV['USE_FDB'] = 'true'

      as_a_mac_system do
        player = FlashPlayer::Executable.new
        player.input = @swf
        player.fdb = true
        player.execute
      end
    end
=end

    should "work with input" do
      player = FlashPlayer::Executable.new
      player.input = @swf
      configure player
      player.execute
    end

    should "update fdb on ci change" do
      player = FlashPlayer::Executable.new
      assert !player.fdb
      assert !player.ci
      player.ci = true
      assert player.fdb
      assert player.ci
    end

    should "call continue on fdb when ci is true" do
      player = FlashPlayer::Executable.new
      player.input = @swf
      player.fdb = true
      player.logger = StringIO.new
      #FlashSDK::FDB.any_instance.expects :execute
      #FlashSDK::FDB.any_instance.expects :run
      #FlashSDK::FDB.any_instance.expects :continue
      #FlashSDK::FDB.any_instance.expects :quit
      player.execute
    end

  end

  private

  def configure player
    player.logger = StringIO.new

    # Comment following lines to really launch the player:
    sys = FakeFlashPlayerSystem.new
    player.stubs(:current_system).returns sys
    sys.expects(:open_flashplayer_with).returns Thread.new{}
  end
end

