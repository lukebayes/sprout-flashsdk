require File.join(File.dirname(__FILE__), "test_helper")

require 'generators/flex_generator'

class FlexGeneratorTest < Test::Unit::TestCase
  include SproutTestCase

  context "A new Flex generator" do

    setup do
      @temp             = File.join(fixtures, 'generators', 'tmp')
      FileUtils.mkdir_p @temp
      @generator        = Sprout::FlexGenerator.new
      @generator.path   = @temp
      @generator.logger = StringIO.new
    end

    teardown do
      remove_file @temp
    end

    should "generate a new Flex" do
      @generator.input = "Flex"
      @generator.execute

      input_dir = File.join(@temp, "flex")
      assert_directory input_dir

      input_file = File.join(input_dir, "Flex.as")
      assert_file input_file do |content|
        assert_matches /Your content to assert here/, content
      end
    end

  end
end
