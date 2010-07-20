module FlashSDK
  class FlexProjectGenerator < ProjectGenerator

    def manifest
      directory input do
        template 'rakefile.rb'
        template 'Gemfile'

        directory src do
          template "#{input.camel_case}.mxml", 'FlexApplication.mxml'
          template "#{test_runner_name}.as", 'ActionScript3RunnerClass.as'
          
          directory assets do
            directory css do
              file 'main.css'
            end
            directory images
            directory fonts
          end
          
        end

        # Create empty directories:
        directory lib
        directory bin
      end
    end

    protected

    def debug_swf_name
      "#{class_name}-debug.swf"
    end

    def test_swf_name
      "#{class_name}-test.swf"
    end

    def test_runner_name
      "#{class_name}Runner"
    end
  end
end
