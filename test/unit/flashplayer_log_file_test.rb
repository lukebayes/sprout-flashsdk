require 'test_helper'

class LogFileTest < Test::Unit::TestCase
  include Sprout::TestHelper

  context "A LogFile" do

    setup do
      @logger = StringIO.new
      @flashlog = File.join(fixtures, 'flashlog.txt')
      @reader = FlashPlayer::LogFile.new
      @reader.logger = @logger
      @reader.stubs(:flashlog_path).returns @flashlog

      FileUtils.touch @flashlog
    end

    teardown do
      remove_file @flashlog
    end

    should "read until killed" do
      blocked = true
      t = Thread.new {
        @reader.tail
        blocked = false
      }

      assert blocked
      t.kill
    end


    # This method only works when run alone -
    # Under normal circumstances, the Sprout::TestHelper
    # clears out any Rake tasks that have been defined
    # and we don't have an easy way to redefine the
    # task...
    #should "read from rake task" do
      #FlashPlayer::LogFile.any_instance.stubs(:logger).returns StringIO.new
      #FlashPlayer::LogFile.any_instance.expects(:read_flashlog_at)
      #Rake.application[:flashlog].invoke
    #end

  end
end

