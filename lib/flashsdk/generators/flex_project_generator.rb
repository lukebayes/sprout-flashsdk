module FlashSDK
  class FlexProjectGenerator < ProjectGenerator

    def manifest
      directory input do
        template 'rakefile.rb'
        template 'Gemfile'

        directory src do
          template "#{input.camel_case}.mxml", 'Flex4Application.mxml'
          template "#{test_runner_name}.mxml", 'Flex4RunnerClass.mxml'

          directory assets do
            directory css do
              file 'Main.css', 'Flex4Main.css'
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

  end
end
