require 'test_helper'

class FCSHTest < Test::Unit::TestCase
  include Sprout::TestHelper

  context "associate FCSH with an MXMLC task" do

    setup do
      @fixture         = File.join fixtures, 'mxmlc', 'simple'
      @input           = File.join @fixture, 'SomeFile.as'
      @expected_output = File.join @fixture, 'SomeFile.swf'
      #Sprout::Log.debug = false
    end

    should "not launch mxmlc" do
      Sprout::Executable.expects(:load).with(:mxmlc).never

      mxmlc          = FlashSDK::MXMLC.new
      mxmlc.input    = @input
      mxmlc.use_fcsh = true
      mxmlc.execute
    end

  end
end

