require File.join(File.dirname(__FILE__), 'test_helper')

class ADLTest < Test::Unit::TestCase
  include SproutTestCase

  context "An ADL tool" do

    setup do
      @fixture         = File.join 'test', 'fixtures', 'adl', 'simple'
      @input           = File.join @fixture, 'SomeFile.as'
      @expected_output = File.join @fixture, 'SomeFile.swf'
      #Sprout::Log.debug = false
    end

    teardown do
      remove_file @expected_output
    end

    should "accept input" do
      as_a_unix_system do
        adl = FlashSDK::ADL.new
        adl.input = @input
        adl.source_path << @fixture
        assert_equal '--source-path+=test/fixtures/adl/simple --static-link-runtime-shared-libraries test/fixtures/adl/simple/SomeFile.as', adl.to_shell
      end
    end

    should "compile a swf" do
      adl = FlashSDK::ADL.new
      adl.input = @input
      adl.execute
      assert_file @expected_output
    end
    

    should "assign default-size" do
      adl = FlashSDK::ADL.new
      adl.default_size = '800,500'
      adl.static_link_runtime_shared_libraries = false
      assert_equal '--default-size=800,500', adl.to_shell
    end

    should "assign simple output" do
      t = adl 'bin/SomeProject.swf' do |t|
        t.input = @input
      end
      assert_equal 'bin/SomeProject.swf', t.output
    end
  end
end

