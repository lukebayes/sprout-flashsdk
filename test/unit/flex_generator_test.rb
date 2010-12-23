require 'test_helper'

class FlexGeneratorTest < Test::Unit::TestCase
  include SproutTestHelper

  context "A new Flex generator" do

    setup do
      @temp             = File.join(fixtures, 'generators', 'tmp')
      FileUtils.mkdir_p @temp
      @generator        = FlashSDK::FlexProjectGenerator.new
      @generator.path   = @temp
      @generator.logger = StringIO.new
    end

    teardown do
      remove_file @temp
    end

    should "generate a new Flex" do
      @generator.input = "Flex"
      @generator.execute

      input_dir = File.join(@temp, "Flex")
      assert_directory input_dir
      
      src_dir = File.join(input_dir, "src")
      assert_directory src_dir
      
      input_file = File.join(src_dir, "Flex.mxml")
      assert_file input_file do |content|
        assert_matches /Flex.mxml::FlexCompleteHandler/, content
      end
    end

  end
end
