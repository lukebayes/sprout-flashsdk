module FlashSDK
  class ProjectGenerator < ClassGenerator

    def manifest
      directory input do
        template 'rakefile.rb'
        template 'Gemfile'

        directory src do
          template "#{input.camel_case}.as", 'ActionScript3MainClass.as'
          template "#{test_runner_name}.as", 'ActionScript3RunnerClass.as'
        end

        directory assets do
          directory skins do
            file 'DefaultProjectImage.png'
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
