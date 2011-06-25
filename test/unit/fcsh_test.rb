require 'test_helper'

class FCSHTest < Test::Unit::TestCase
  include Sprout::TestHelper

  context "associate FCSH with an MXMLC task" do

    setup do
      @fixture         = File.join fixtures, 'mxmlc'
      @input           = File.join @fixture, 'simple', 'SomeFile.as'
      @broken_input    = File.join @fixture, 'broken', 'SomeFile.as'
      @expected_output = File.join @fixture, 'simple', 'SomeFile.swf'

      # Uncomment following to see output:
      #Sprout.stdout = $stdout
      #Sprout.stderr = $stderr
    end

    teardown do
      remove_file @expected_output
    end
=begin
    should "collect errors as needed" do
      mxmlc = FlashSDK::MXMLC.new
      mxmlc.input = @broken_input

      fcsh = FlashSDK::FCSH.new
      fcsh.execute false
      fcsh.mxmlc mxmlc.to_shell
      fcsh.quit
      fcsh.wait

      expected_error_message = '1 Error: Syntax error: expecting rightbrace before end of program'
      assert_matches /#{expected_error_message}/, Sprout.stdout.read
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
=end
  end
end

