require 'test_helper'

class ADLTest < Test::Unit::TestCase
  include Sprout::TestHelper

  context "An ADL tool" do

    setup do
      @fixture  = File.join 'test', 'fixtures', 'air', 'simple'
      @app_desc = File.join @fixture, 'SomeProject.xml'
			@profile = 'mobileDevice'
			@screensize = 'NexusOne'
    end

    teardown do
    end

    should "accept input" do
      adl = FlashSDK::ADL.new
      adl.app_desc = @app_desc
      adl.root_dir = Dir.pwd
			adl.screensize = @screensize
			adl.profile = @profile
      assert_equal "-profile #{@profile} -screensize #{@screensize} #{@app_desc} #{Dir.pwd}", adl.to_shell
      # Uncomment to actually launch
      # the AIR application:
      #adl.execute
    end

  end
end

