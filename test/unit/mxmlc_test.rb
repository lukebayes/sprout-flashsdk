require 'test_helper'

class MXMLCTest < Test::Unit::TestCase
  include Sprout::TestHelper

  context "An MXMLC tool" do

    setup do
      @original_use_fcsh_value = ENV['USE_FCSH']
      @fixture                 = File.join fixtures, 'mxmlc', 'simple'
      @input                   = File.join @fixture, 'SomeFile.as'
      @expected_output         = File.join @fixture, "SomeFile.swf"
    end

    teardown do
      remove_file @expected_output
      ENV['USE_FCSH'] = @original_use_fcsh_value
    end

    should "compile a swf" do
      as_a_unix_system do
        mxmlc = FlashSDK::MXMLC.new
        # Comment out following line to use REAL Mxmlc:
        mxmlc.binary_path = File.join fixtures, 'sdk', 'mxmlc'
        mxmlc.input = @input
        mxmlc.output = @expected_output
        mxmlc.execute
        assert_file @expected_output
      end
    end

    should "accept input" do
      as_a_unix_system do
        mxmlc = FlashSDK::MXMLC.new
        mxmlc.input = 'test/fixtures/mxmlc/simple/SomeFile.as'
        mxmlc.source_path << 'test/fixtures/mxmlc/simple'
        assert_equal '-source-path+=test/fixtures/mxmlc/simple test/fixtures/mxmlc/simple/SomeFile.as', mxmlc.to_shell
      end
    end

    should "assign default-size" do
      mxmlc = FlashSDK::MXMLC.new
      mxmlc.default_size = '800,500'
      assert_equal '-default-size=800,500', mxmlc.to_shell
    end

    should "assign simple output" do
      t = mxmlc 'bin/SomeProject.swf' do |t|
        t.input = @input
      end
      assert_equal 'bin/SomeProject.swf', t.output
    end

    should "use fcsh if specified" do
      Sprout::Executable.expects(:load).with(:mxmlc).never

      mxmlc          = FlashSDK::MXMLC.new
      mxmlc.expects(:execute_with_fcsh)
      mxmlc.input    = @input
      mxmlc.use_fcsh = true
      mxmlc.execute
    end
  end
end

