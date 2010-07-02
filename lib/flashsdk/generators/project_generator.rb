module FlashSDK
  class ProjectGenerator < ClassGenerator

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
