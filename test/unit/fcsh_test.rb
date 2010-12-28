require 'test_helper'

class FCSHTest < Test::Unit::TestCase
  include Sprout::TestHelper

  context "associate FCSH with an MXMLC task" do

    setup do
      @fixture         = File.join fixtures, 'mxmlc', 'simple'
      @input           = File.join @fixture, 'SomeFile.as'
      @expected_output = File.join @fixture, 'SomeFile.swf'
    end

    teardown do
      remove_file @expected_output
    end

    should "spin up FCSH" do
      mxmlc = FlashSDK::MXMLC.new
      mxmlc.input = @input

      fcsh = FlashSDK::FCSH.new
      fcsh.execute false
      fcsh.mxmlc mxmlc.to_shell
      FileUtils.touch @input
      fcsh.compile 1
      fcsh.quit
      fcsh.wait

      assert_file @expected_output
    end

  end
end

