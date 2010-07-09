require File.join(File.dirname(__FILE__), 'test_helper')

class ADLTest < Test::Unit::TestCase
  include SproutTestCase

  context "An ADL tool" do

    setup do
      @fixture  = File.join 'test', 'fixtures', 'air', 'simple'
      @app_desc = File.join @fixture, 'SomeProject.xml'

      #Sprout::Log.debug = false
    end

    teardown do
    end

    should "accept input" do
      adl = FlashSDK::ADL.new
      adl.app_desc = @app_desc
      adl.root_dir = Dir.pwd
      assert_equal 'test/fixtures/air/simple/SomeProject.xml /Users/lbayes/Projects/Sprouts/flashsdk', adl.to_shell
      # Uncomment to actually launch
      # the AIR application:
      #adl.execute
    end

  end
end

