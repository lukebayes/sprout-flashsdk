
module FlashSDK

  ##
  # This Generator will create a new ActionScript class
  # based on the +ActionScript3Class.as+ template.
  #
  # This Generator should only be executed from within
  # a project that has a Gemfile. If your Gemfile
  # loads the "asunit4" gem, a test case and test suite
  # will also be created whenever this generator is run.
  #
  # You can run this generator as follows:
  #
  #   $ sprout-class utils.MathUtil
  # 
  # You can prevent the creation of a test case and test 
  # suite by sending in the +--no-test+ parameter as follows:
  #
  #   $ sprout-class utils.MathUtil --no-test
  #
  class ClassGenerator < Sprout::Generator::Base
    include FlashHelper
    
    ##
    # @return [String] The default package to use.    
    add_param :package, String, { :default => ""}
    
    ##
    # @return [String] The path where assets will be created.
    add_param :assets, String, { :default => 'assets' }

    ##
    # @return [String] The path where skins will be created.
    add_param :skins, String, { :default => 'skins' }

    ##
    # @return [String] The path where test cases should be created.
    add_param :test, String, { :default => 'test' }

    ##
    # @return [String] The path where libraries should be added.
    add_param :lib, String, { :default => 'lib' }

    ##
    # @return [String] The path where binaries should be created.
    add_param :bin, String, { :default => 'bin' }

    ##
    # @return [String] The path where source files should be created.
    add_param :src, String, { :default => 'src' }

    ##
    # @return [String] The path where documentation should be created.
    add_param :doc, String, { :default => 'doc' }

    ##
    # @return [Boolean] Call the TestClassGenerator after creating class.
    add_param :test_class, Boolean, { :default => true }

    def manifest
      if(!input.match(/Test$/))
        directory class_directory do
          template "#{class_name}.as", 'ActionScript3Class.as'
        end
      end

      if test_class
        generator :test_class, :input => "#{fully_qualified_class_name}Test"
      end
    end

  end
end

module FlashSDK
  ##
  # This is a null Generator, if you add a test library
  # to your Gemfile, it should have it's own TestClassGenerator
  # that supercedes this one.
  class TestClassGenerator < Sprout::Generator::Base

    def manifest
    end
  end
end

