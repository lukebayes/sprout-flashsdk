module FlashSDK

  class ADL < Sprout::Executable::Base

    add_param :runtime, Path

    add_param :pubid, String

    add_param :nodebug, Boolean

    add_param :profile, String

    add_param :screensize, String

    add_param :app_desc, String, { :hidden_name => true, :delimiter => ' ' }

    add_param :root_dir, String, { :hidden_name => true, :delimiter => ' ' }

    #add_param :shitty_dashes, String, { :hidden_name => true, :delimiter => ' ', :default => '--' }

    add_param :input, File, { :hidden_name => true }

    ##
    # The the Ruby file that will load the expected
    # Sprout::Specification.
    #
    # Default value is 'flex4'
    #
    set :pkg_name, 'flex4'

    ##
    # The default pkg version
    #
    set :pkg_version, ">= #{FlashSDK::VERSION}"
    
    ##
    # The default executable target.
    #
    set :executable, :adl
  end
end

def adl *args, &block
  exe = FlashSDK::ADL.new
  exe.to_rake(*args, &block)
  exe
end

##
# TODO: This should NOT be here!
# This is preventing that method from working
# as expected only after this FILE is required.
class Sprout::System::UnixSystem

    def should_repair_executable path
      return false
      #return (File.exists?(path) && !File.directory?(path) && File.read(path).match(/^\#\!\/bin\/sh/))
    end
end
