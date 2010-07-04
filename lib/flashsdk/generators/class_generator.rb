module FlashSDK
  class ClassGenerator < Sprout::Generator::Base
    include FlashHelper

    ##
    # The path where assets will be created.
    add_param :assets, String, { :default => 'assets' }

    ##
    # The path where skins will be created.
    add_param :skins, String, { :default => 'skins' }

    ##
    # The path where test cases should be created.
    add_param :test, String, { :default => 'test' }

    ##
    # The path where libraries should be added.
    add_param :lib, String, { :default => 'lib' }

    ##
    # The path where binaries should be created.
    add_param :bin, String, { :default => 'bin' }

    ##
    # The path where source files should be created.
    add_param :src, String, { :default => 'src' }

    ##
    # Do not create a test case for this class.
    add_param :no_test, Boolean

    def manifest
      if(!input.match(/Test$/))
        directory class_directory do
          template "#{class_name}.as", 'ActionScript3Class.as'
        end
      end

      unless no_test
        generator :test_class, :input => "#{fully_qualified_class_name}Test"
      end
    end

  end
end

##
# This is a null Generator, if you add a test library
# to your Gemfile, it should have it's own TestClassGenerator
# that supercedes this one.
module FlashSDK
  class TestClassGenerator < Sprout::Generator::Base
    def manifest
    end
  end
end

