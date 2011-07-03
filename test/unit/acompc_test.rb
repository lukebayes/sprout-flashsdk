require 'test_helper'

class ACOMPCTest < Test::Unit::TestCase
  include Sprout::TestHelper

  context "An ACOMPC tool" do

    setup do
      @fixture         = File.join 'test', 'fixtures', 'acompc', 'simple'
      @input           = File.join @fixture, 'SomeAirFile.as'
      @expected_output = File.join @fixture, 'SomeAirFile.swc'
    end

    teardown do
      remove_file @expected_output
    end

    should "accept input" do
      as_a_unix_system do
        compc = FlashSDK::ACOMPC.new
        compc.output = @expected_output
        compc.include_sources << @fixture
        assert_equal '--output=test/fixtures/acompc/simple/SomeAirFile.swc --static-link-runtime-shared-libraries --include-sources+=test/fixtures/acompc/simple', compc.to_shell
      end
    end

    should "compile a swc" do
      compc = FlashSDK::ACOMPC.new
      compc.include_sources << @fixture
      compc.output = @expected_output
      compc.execute
      assert_file @expected_output
    end

  end
end

