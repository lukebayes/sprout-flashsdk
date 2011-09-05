require 'test_helper'

class FlexCompilerOptionsTest < Test::Unit::TestCase
  include Sprout::TestHelper

  # formal tests for a variety of Flex compiler options and how they should appear on the CLI based on true/false settings
  context "A Flex compiler's options" do

    setup do
      @mxmlc = FlashSDK::MXMLC.new
    end

    teardown do
    end

    # -as3
    should "default to as3=true" do
      assert_equal true, @mxmlc.as3
    end

    should "not include a -as3 flag if :as3 is set to true" do
      @mxmlc.as3 = true
      assert_no_match /-as3/, @mxmlc.to_shell
    end

    should "include -as3=false flag if :as3 is set to false" do
      @mxmlc.as3 = false
      assert_equal '-as3=false', @mxmlc.to_shell
    end

    # -benchmark
    should "default to benchmark=true" do
      assert_equal true, @mxmlc.benchmark
    end

    should "not include a -benchmark flag if :benchmark is set to true" do
      @mxmlc.benchmark = true
      assert_no_match /-benchmark/, @mxmlc.to_shell
    end

    should "include -benchmark=false flag if :benchmark is set to false" do
      @mxmlc.benchmark = false
      assert_equal '-benchmark=false', @mxmlc.to_shell
    end

    # -debug
    should "default to debug=false" do
      assert_equal false, @mxmlc.debug
    end

    should "not include a -debug flag if :debug is set to false" do
      assert_no_match /-debug/, @mxmlc.to_shell
    end

    should "include -debug flag if :debug is set to true" do
      @mxmlc.debug = true
      assert_equal '-debug', @mxmlc.to_shell
    end

    # -use-network
    should "default to use_network=false" do
      assert_equal true, @mxmlc.use_network
    end

    should "not include a -use-network flag if :use_network is set to true" do
      @mxmlc.use_network = true
      assert_no_match /-use-network/, @mxmlc.to_shell
    end

    should "include -use-network=false flag if :use_network is set to false" do
      @mxmlc.use_network = false
      assert_equal '-use-network=false', @mxmlc.to_shell
    end

    # -optimize
    should "default to optimize=true" do
      assert_equal true, @mxmlc.optimize
    end

    should "not include a -optimize flag if :optimize is set to true" do
      @mxmlc.optimize = true
      assert_no_match /-optimize/, @mxmlc.to_shell
    end

    should "include -optimize=false flag if :optimize is set to false" do
      @mxmlc.optimize = false
      assert_equal '-optimize=false', @mxmlc.to_shell
    end

    # -show-actionscript-warnings
    should "default to show-actionscript-warnings=true" do
      assert_equal true, @mxmlc.show_actionscript_warnings
    end

    should "not include a -show-actionscript-warnings flag if :show-actionscript-warnings is set to true" do
      @mxmlc.show_actionscript_warnings = true
      assert_no_match /-show-actionscript-warnings/, @mxmlc.to_shell
    end

    should "include -show-actionscript-warnings=false flag if :show-actionscript-warnings is set to false" do
      @mxmlc.show_actionscript_warnings = false
      assert_equal '-show-actionscript-warnings=false', @mxmlc.to_shell
    end

    # -show-binding-warnings
    should "default to show-binding-warnings=true" do
      assert_equal true, @mxmlc.show_binding_warnings
    end

    should "not include a -show-binding-warnings flag if :show-binding-warnings is set to true" do
      @mxmlc.show_binding_warnings = true
      assert_no_match /-show-binding-warnings/, @mxmlc.to_shell
    end

    should "include -show-binding-warnings=false flag if :show-binding-warnings is set to false" do
      @mxmlc.show_binding_warnings = false
      assert_equal '-show-binding-warnings=false', @mxmlc.to_shell
    end

    # -show-shadowed-device-font-warnings
    should "default to show-shadowed-device-font-warnings=true" do
      assert_equal true, @mxmlc.show_shadowed_device_font_warnings
    end

    should "not include a -show-shadowed-device-font-warnings flag if :show-shadowed-device-font-warnings is set to true" do
      @mxmlc.show_shadowed_device_font_warnings = true
      assert_no_match /-show-shadowed-device-font-warnings/, @mxmlc.to_shell
    end

    should "include -show-shadowed-device-font-warnings=false flag if :show-shadowed-device-font-warnings is set to false" do
      @mxmlc.show_shadowed_device_font_warnings = false
      assert_equal '-show-shadowed-device-font-warnings=false', @mxmlc.to_shell
    end

    # -show-unused-type-selector-warnings
    should "default to show-unused-type-selector-warnings=true" do
      assert_equal true, @mxmlc.show_unused_type_selector_warnings
    end

    should "not include a -show-unused-type-selector-warnings flag if :show-unused-type-selector-warnings is set to true" do
      @mxmlc.show_unused_type_selector_warnings = true
      assert_no_match /-show-unused-type-selector-warnings/, @mxmlc.to_shell
    end

    should "include -show-unused-type-selector-warnings=false flag if :show-unused-type-selector-warnings is set to false" do
      @mxmlc.show_unused_type_selector_warnings = false
      assert_equal '-show-unused-type-selector-warnings=false', @mxmlc.to_shell
    end

    # -static-link-runtime-shared-libraries
    should "default to static-link-runtime-shared-libraries=true" do
      assert_equal true, @mxmlc.static_link_runtime_shared_libraries
    end

    should "not include a -static-link-runtime-shared-libraries flag if :static-link-runtime-shared-libraries is set to true" do
      @mxmlc.static_link_runtime_shared_libraries = true
      assert_no_match /-static-link-runtime-shared-libraries/, @mxmlc.to_shell
    end

    should "include -static-link-runtime-shared-libraries=false flag if :static-link-runtime-shared-libraries is set to false" do
      @mxmlc.static_link_runtime_shared_libraries = false
      assert_equal '-static-link-runtime-shared-libraries=false', @mxmlc.to_shell
    end

    # -strict
    should "default to strict=true" do
      assert_equal true, @mxmlc.strict
    end

    should "not include a -strict flag if :strict is set to true" do
      @mxmlc.strict = true
      assert_no_match /-strict/, @mxmlc.to_shell
    end

    should "include -strict=false flag if :strict is set to false" do
      @mxmlc.strict = false
      assert_equal '-strict=false', @mxmlc.to_shell
    end

    # -use-resource-bundle-metadata
    should "default to use-resource-bundle-metadata=true" do
      assert_equal true, @mxmlc.use_resource_bundle_metadata
    end

    should "not include a -use-resource-bundle-metadata flag if :use-resource-bundle-metadata is set to true" do
      @mxmlc.use_resource_bundle_metadata = true
      assert_no_match /-use-resource-bundle-metadata/, @mxmlc.to_shell
    end

    should "include -use-resource-bundle-metadata=false flag if :use-resource-bundle-metadata is set to false" do
      @mxmlc.use_resource_bundle_metadata = false
      assert_equal '-use-resource-bundle-metadata=false', @mxmlc.to_shell
    end

    # -warnings
    should "default to warnings=true" do
      assert_equal true, @mxmlc.warnings
    end

    should "not include a -warnings flag if :warnings is set to true" do
      @mxmlc.warnings = true
      assert_no_match /-warnings/, @mxmlc.to_shell
    end

    should "include -warnings=false flag if :warnings is set to false" do
      @mxmlc.warnings = false
      assert_equal '-warnings=false', @mxmlc.to_shell
    end


  end
end

