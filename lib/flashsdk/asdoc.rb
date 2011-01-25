module FlashSDK

  class AsDoc < CompilerBase

    ##
    # The default prefix for shell params.
    set :default_prefix, '-'

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
    set :executable, :asdoc

    ##
    # Boolean specifies whether to include the date in the footer.
    add_param :date_in_footer, Boolean

    ##
    # List of source file to include in the documentation.
    add_param :doc_sources, Files

    add_param_alias :ds, :doc_sources

    ##
    # List of classes to include in the documentation.
    add_param :doc_classes, Strings

    ##
    # List of namespaces to include in the documentation.
    add_param :doc_namespaces, Strings

    ##
    # Path to look for the example files.
    add_param :examples_path, Paths

    ##
    # Classes to exclude from documentation.
    add_param :exclude_classes, Strings

    ##
    # Boolean specifying whether to exclude dependencies.
    add_param :exclude_dependencies, Boolean

    ##
    # List of source files to exclude form the documentation.
    add_param :exclude_sources, Files

    ##
    # Footer string to be displayed in the documentation.
    add_param :footer, String

    add_param :include_all_for_asdoc, Boolean

    ##
    # If true, manifest entries with lookupOnly=true are included in SWC 
    # catalog. Default is false. (advanced)
    add_param :include_lookup_only, Boolean, { :default => false }

    ##
    # Width of the left frame.
    add_param :left_frameset_width, Number

    ##
    # Report well-formed HTML errors as warnings.
    add_param :lenient, Boolean

    ##
    # Title to be displayed in the title bar.
    add_param :main_title, String

    ##
    # File containing description for packages.
    add_param :package_description_file, Files

    ##
    # Specifies a description for a package name.
    add_param :package, Path
    
    ##
    # Path for custom templates.
    add_param :templates_path, Path

    ##
    # Title to be displayed in the browser window.
    add_param :window_title, String

    # TODO: Possibly remove the following from the CompilerBase
    #
    # include_resource_bundles

    def execute
      # Never use fcsh for asdoc
      # (overused inheritance smell)
      self.use_fcsh = false
      start = Time.now
      super
      duration = (Time.now - start).seconds
      Sprout.stdout.puts "[ASDOC] Creation complete in #{duration} seconds."
    end

  end
end

##
# Create a new Rake::File task that will execute {FlashSDK::AsDoc}.
#
# @return [FlashSDK::AsDoc]
#
# @example The following is a simple AsDoc task:
#
#   desc "Compile the SWF"
#   mxmlc 'bin/SomeProject.swf' do |t|
#     t.library_path << 'lib/corelib.swc'
#     t.input = 'src/SomeProject.as'
#   end
#
#   desc "Generate documentation"
#   asdoc 'docs/' do |t|
#     t.doc_sources << 'src'
#   end
#
def asdoc args, &block
  exe = FlashSDK::AsDoc.new
  exe.to_rake args, &block
  exe
end

