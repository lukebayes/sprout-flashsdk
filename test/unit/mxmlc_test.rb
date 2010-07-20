require File.join(File.dirname(__FILE__), 'test_helper')

class MXMLCTest < Test::Unit::TestCase
  include SproutTestCase

  context "An MXMLC tool" do

    setup do
      @fixture         = File.join fixtures, 'mxmlc', 'simple'
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
        mxmlc.input = 'test/fixtures/mxmlc/simple/SomeFile.as'
        mxmlc.source_path << 'test/fixtures/mxmlc/simple'
        assert_equal '-source-path+=test/fixtures/mxmlc/simple -static-link-runtime-shared-libraries test/fixtures/mxmlc/simple/SomeFile.as', mxmlc.to_shell
      end
    end

    should "compile a swf" do
      mxmlc = FlashSDK::MXMLC.new
      mxmlc.input = @input
      mxmlc.execute
      assert_file @expected_output
    end
    

    should "assign default-size" do
      mxmlc = FlashSDK::MXMLC.new
      mxmlc.default_size = '800,500'
      mxmlc.static_link_runtime_shared_libraries = false
      assert_equal '-default-size=800,500', mxmlc.to_shell
    end

    should "assign simple output" do
      t = mxmlc 'bin/SomeProject.swf' do |t|
        t.input = @input
      end
      assert_equal 'bin/SomeProject.swf', t.output
    end
  end
end

