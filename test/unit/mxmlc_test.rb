require File.join(File.dirname(__FILE__), 'test_helper')

class MXMLCTest < Test::Unit::TestCase
  include SproutTestCase

  context "An MXMLC tool" do

    setup do
      @fixture         = File.join 'test', 'fixtures', 'mxmlc', 'simple'
      @input           = File.join @fixture, 'SomeFile.as'
      @expected_output = File.join @fixture, 'SomeFile.swf'
      #Sprout::Log.debug = false
    end

    teardown do
      remove_file @expected_output
    end

    should "accept input" do
      as_a_unix_system do
        mxmlc = FlashSDK::MXMLC.new
        mxmlc.input = @input
        mxmlc.source_path << @fixture
        assert_equal '--source-path+=test/fixtures/mxmlc/simple test/fixtures/mxmlc/simple/SomeFile.as', mxmlc.to_shell
      end
    end

    should "compile a swf" do
      mxmlc = FlashSDK::MXMLC.new
      mxmlc.input = @input
      # Turn on to trigger an actual compilation:
      # (This is too damn slow to leave in the every-time test run)
      mxmlc.execute
      assert_file @expected_output
    end

    should "assign simple output" do
      t = mxmlc 'bin/SomeProject.swf' do |t|
        t.input = @input
      end
      assert_equal 'bin/SomeProject.swf', t.output
    end
  end
end

