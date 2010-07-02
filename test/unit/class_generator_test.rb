require File.join(File.dirname(__FILE__), "test_helper")

class ClassGeneratorTest < Test::Unit::TestCase
  include SproutTestCase

  context "a new class generator" do

    setup do
      @temp = File.join(fixtures, 'generators', 'tmp')
      FileUtils.mkdir_p @temp
      @generator = FlashSDK::ClassGenerator.new
      @generator.path = @temp
      @generator.logger = StringIO.new

      Sprout::Generator.register FlashSDK::ClassGenerator
      Sprout::Generator.register FlashSDK::TestClassGenerator
      Sprout::Generator.register FlashSDK::SuiteClassGenerator
    end

    teardown do
      remove_file @temp
    end

    should "work with a simple class" do
      @generator.input = 'utils.MathUtil'
      @generator.execute
      assert_file File.join(@temp, 'src', 'utils', 'MathUtil.as')
    end

    should "work with no package" do
      @generator.input = 'MathUtil'
      @generator.execute
      assert_file File.join(@temp, 'src', 'MathUtil.as')
    end

    should "work with directory instead of dots" do
      @generator.input = 'src/utils/MathUtil.as'
      @generator.execute
      assert_file File.join(@temp, 'src', 'utils', 'MathUtil.as')
    end

    should "work with directory but no source" do
      @generator.input = 'utils/MathUtil.as'
      @generator.execute
      assert_file File.join(@temp, 'src', 'utils', 'MathUtil.as')
    end
  end

end

