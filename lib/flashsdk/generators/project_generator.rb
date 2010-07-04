module FlashSDK
  class ProjectGenerator < ClassGenerator

    def manifest
      directory input do
        template 'rakefile.rb'
        template 'Gemfile'

        directory src do
          template "#{input}.as", 'ActionScript3MainClass.as'
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
  end
end
