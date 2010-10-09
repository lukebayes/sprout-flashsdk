module FlashSDK
  class ProjectGenerator < ClassGenerator

    add_param :css, Path, { :default => 'css' }
    add_param :images, Path, { :default => 'images' }
    add_param :fonts, Path, { :default => 'fonts' }    
        
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

  end
end
