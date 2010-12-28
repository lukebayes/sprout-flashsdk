require 'test_helper'

class AMXMLCTest < Test::Unit::TestCase
  include Sprout::TestHelper

  context "An AMXMLC tool" do

    setup do
      @fixture         = File.join 'test', 'fixtures', 'air', 'simple'
      @input           = File.join @fixture, 'SomeProject.as'
      @expected_output = File.join @fixture, 'bin', 'SomeProject.swf'
    end

    teardown do
      remove_file File.join(@fixture, 'bin')
    end

    should "accept input" do
      as_a_unix_system do
        amxmlc = FlashSDK::AMXMLC.new
        amxmlc.input = @input
        amxmlc.source_path << @fixture
        assert_equal '-source-path+=test/fixtures/air/simple -static-link-runtime-shared-libraries test/fixtures/air/simple/SomeProject.as', amxmlc.to_shell
      end
    end

    should "compile a swf" do
      insert_fake_executable File.join(fixtures, 'sdk', 'mxmlc')
      FileUtils.mkdir_p File.dirname(@expected_output)

      amxmlc        = FlashSDK::AMXMLC.new
      amxmlc.input  = @input
      amxmlc.output = @expected_output
      amxmlc.execute
      assert_file @expected_output
    end
    

    should "assign default-size" do
      amxmlc = FlashSDK::AMXMLC.new
      amxmlc.default_size = '800,500'
      amxmlc.static_link_runtime_shared_libraries = false
      assert_equal '-default-size=800,500', amxmlc.to_shell
    end

    should "assign simple output" do
      as_a_unix_system do
        t = amxmlc 'bin/SomeProject.swf' do |t|
          t.input = @input
        end
        assert_equal '-output=bin/SomeProject.swf -static-link-runtime-shared-libraries test/fixtures/air/simple/SomeProject.as', t.to_shell
      end
    end
  end
end

