require 'test_helper'

class COMPCTest < Test::Unit::TestCase
  include SproutTestHelper

  context "An COMPC tool" do

    setup do
      @fixture         = File.join 'test', 'fixtures', 'compc', 'simple'
      @input           = File.join @fixture, 'SomeFile.as'
      @expected_output = File.join @fixture, 'SomeFile.swc'
      #Sprout::Log.debug = false
    end

    teardown do
      remove_file @expected_output
    end

    should "accept input" do
      as_a_unix_system do
        compc = FlashSDK::COMPC.new
        compc.output = @expected_output
        compc.include_sources << @fixture
        assert_equal '--output=test/fixtures/compc/simple/SomeFile.swc --static-link-runtime-shared-libraries --include-sources+=test/fixtures/compc/simple', compc.to_shell
      end
    end

    should "compile a swc" do
      compc = FlashSDK::COMPC.new
      compc.include_sources << @fixture
      compc.output = @expected_output
      compc.execute
      assert_file @expected_output
    end

  end
end

