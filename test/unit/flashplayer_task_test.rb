require File.join(File.dirname(__FILE__), 'test_helper')

class TaskTest < Test::Unit::TestCase
  include SproutTestCase

  context "A FlashPlayerTask" do

    setup do
      # Force reload of the Specification on each
      # test method b/c SproutTestCase calls
      # Executable.clear_entities! but 'require'
      # only runs once per VM run...
      load 'flashplayer/specification.rb'
      @swf          = File.join(fixtures, 'flashplayer', 'AsUnit Runner.swf')
      @missing_home = File.join(fixtures, 'missing_folder')
      @config_path  = File.join(@missing_home, 'fp_config', 'mm.cfg')
    end

    teardown do
      remove_file @missing_home
    end

=begin
    ## THIS METHOD WAS COMMENTED OUT....
    should "wait for SWF even if clean system" do
      # No creation of expected FlashPlayer folders...

      FlashPlayer.stubs(:home).returns @missing_home
      FlashPlayer::MMConfig.any_instance.stubs(:system_home).returns @missing_home
      FlashPlayer::MMConfig.any_instance.stubs(:config_path).returns @config_path
      FlashPlayer::MMConfig.any_instance.stubs(:user_confirmation?).returns false

      as_a_mac_system do
        t = flashplayer @swf
        t.invoke
      end
    end
=end

    should "work with swf as task name" do
      t = flashplayer @swf
      configure_task t
      t.invoke
    end

    should "work with swf in block" do
      t = flashplayer :run do |t|
        t.input = @swf
      end
      file @swf
      configure_task t
      t.invoke
      assert_equal @swf, t.input
    end

    should "work with swf as prerequisite" do
      t = flashplayer :run => @swf
      file @swf
      configure_task t
      t.invoke
      assert_equal @swf, t.input
    end

    should "fire when declared as a dependency" do
      t = flashplayer :run => @swf
      file @swf
      configure_task t
      other = task :parent => :run
      other.invoke
    end
  end

  private

  def configure_task t
    t.logger = StringIO.new

    # Comment following lines to really launch the player:
    sys = FakeSystem.new
    t.stubs(:current_system).returns sys
    sys.expects(:open_flashplayer_with).returns Thread.new{}
  end
end

class FakeSystem

  def clean_path path
    path
  end

  def open_flashplayer_with player, swf
  end
end

