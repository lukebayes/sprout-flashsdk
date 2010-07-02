module FlashSDK
  class ClassGenerator < Sprout::Generator::Base

    ##
    # The path where source files should be created.
    add_param :src, String, { :default => 'src' }

    def manifest
      directory class_directory do
        template "#{class_name}.as", 'ActionScript3Class.as'
        #generator :test_class, :input => "#{fully_qualified_class_name}Test"
      end
    end

    #def generator name, options=nil
      #class_name = "#{name.to_s.camel_case}Generator"
      #instance = Sprout::Generator.create_instance class_name
      #instance.from_hash to_hash.merge(options)
      #instance.execute
    #end

    protected

      def class_directory
        parts = input_in_parts
        if parts.size > 1
          parts.pop
          return File.join src, *parts
        end
        return src
      end

      def package_name
        parts = input_in_parts
        if parts.size > 1
          parts.pop
          return "#{parts.join('.')} "
        end
        return ""
      end

      def class_name
        parts = input_in_parts
        parts.pop.camel_case
      end

      def input_in_parts
        provided_input = input
        if provided_input.include?('/')
          provided_input.gsub! /^#{src}\//, ''
          provided_input = provided_input.split('/').join('.')
        end

        provided_input.gsub!(/\.as$/, '')
        provided_input.gsub!(/\.mxml$/, '')
        provided_input.gsub!(/\.xml$/, '')

        provided_input.split('.')
      end

  end

end

##
# This is a null Test Generator
module AS3
  class TestClassGenerator < Sprout::Generator::Base
    def manifest
    end
  end
end

##
# This is a null Suite Generator
module AS3
  class SuiteClassGenerator < Sprout::Generator::Base
    def manifest
    end
  end
end

