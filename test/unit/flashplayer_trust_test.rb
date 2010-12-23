require 'test_helper'

class TrustTest < Test::Unit::TestCase
  include SproutTestHelper

  context "A Trust instance" do

    setup do
      @fixture      = File.join fixtures, 'trust'
      @file         = File.join @fixture, 'trust.cfg'
      @project      = File.join fixtures, 'SomeProject'
      @trust        = FlashPlayer::Trust.new
      @trust.logger = StringIO.new
      @trust.stubs(:trust_file).returns @file
    end

    teardown do
      remove_file @fixture
    end

    should "create and update trust config with provided path" do
      @trust.add @project

      assert_file @file do |content|
        assert_matches File.expand_path(@project), content
      end
    end
  end
end

