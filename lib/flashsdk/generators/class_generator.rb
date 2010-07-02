module FlashSDK
  class ClassGenerator < Sprout::Generator::Base
    include FlashHelper

    ##
    # The path where source files should be created.
    add_param :src, String, { :default => 'src' }

    def manifest
      directory class_directory do
        template "#{class_name}.as", 'ActionScript3Class.as'
        generator :test_class, :input => "#{fully_qualified_class_name}Test"
        generator :suite_class
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

##
# This is a null Generator, if you add a test library
# to your Gemfile, it should have it's own TestClassGenerator
# that supercedes this one.
module FlashSDK
  class SuiteClassGenerator < Sprout::Generator::Base
    def manifest
    end
  end
end

