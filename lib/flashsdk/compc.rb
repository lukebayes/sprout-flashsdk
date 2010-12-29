module FlashSDK

  ##
  # The COMPC compiler is a tool that creates SWC libraries from source code.
  #
  # Following is an example of the creation of a simple SWC file:
  #
  #   compc 'bin/SomeProject.swc' do |t|
  #     t.include_classes << 'SomeProject'
  #     t.source_path << 'src'
  #   end
  # 
  #   desc 'Compile the SWC'
  #   task :swc => 'bin/SomeProject.swc'
  #
  class COMPC < CompilerBase

    ##
    # Outputs the SWC content as a SWF into an open directory format rather than a SWC file.
    #
    # This is especially useful for creating Runtime Shared Libraries.
    #
    #   compc "bin/rsls/foo" do |t|
    #     t.directory = true
    #     t.include_sources = 'src'
    #   end
    #
    # @see Sprout::COMPC#include_sources
    # 
    add_param :directory, Boolean

    ##
    # Specifies classes to include in the SWC file. You provide the class name (for example, MyClass) rather than the file name (for example, MyClass.as) to the file for this option. As a result, all classes specified with this option must be in the compiler's source path. You specify this by using the source-path compiler option.
    #
    # You can use packaged and unpackaged classes. To use components in namespaces, use the include-namespaces option.
    #
    # If the components are in packages, ensure that you use dot-notation rather than slashes to separate package levels.
    #
    # This is the default option for the component compiler.
    #
    add_param :include_classes, Strings

    add_param_alias :ic, :include_classes


    ##
    # Adds the file to the SWC file. This option does not embed files inside the library.swf file. This is useful for skinning and theming, where you want to add non-compiled files that can be referenced in a style sheet or embedded as assets in MXML files.
    #
    # If you use the [Embed] syntax to add a resource to your application, you are not required to use this option to also link it into the SWC file.
    #
    # For more information, see Adding nonsource classes (http://livedocs.adobe.com/flex/201/html/compilers_123_39.html#158900).
    #
    add_param :include_file, Files

    add_param :include_lookup_only, Boolean

    ##
    # Specifies namespace-style components in the SWC file. You specify a list of URIs to include in the SWC file. The uri argument must already be defined with the namespace option.
    #
    # To use components in packages, use the include-classes option.
    #
    add_param :include_namespaces, Strings

    ##
    # Specifies the resource bundles to include in this SWC file. All resource bundles specified with this option must be in the compiler's source path. You specify this using the source-path compiler option.
    #
    # For more information on using resource bundles, see Localizing Flex Applications (http://livedocs.adobe.com/flex/201/html/l10n_076_1.html#129288) in Flex 2 Developer's Guide.
    #
    add_param :include_resource_bundles, Files

    ##
    # Specifies classes or directories to add to the SWC file. When specifying classes, you specify the path to the class file (for example, MyClass.as) rather than the class name itself (for example, MyClass). This lets you add classes to the SWC file that are not in the source path. In general, though, use the include-classes option, which lets you add classes that are in the source path.
    #
    # If you specify a directory, this option includes all files with an MXML or AS extension, and ignores all other files.
    #
    #   compc "bin/SomeProject.swc" do |t|
    #     t.include_sources << 'src'
    #     t.library_path << 'lib/somelib.swc'
    #   end
    #
    # You'll need to be sure your source path and library path are both set up properly for this work.
    #
    add_param :include_sources, Paths

    ##
    # Not sure about this option, it was in the CLI help, but not documented on the Adobe site
    #
    add_param :namespace, String

    ##
    # Main source Class to send compiler.
    # If used, this should be the last item in the list
    add_param :input_class, String, { :hidden_name => true }


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
    set :executable, :compc
  end
end

def compc args, &block
  exe = FlashSDK::COMPC.new
  exe.to_rake(args, &block)
  exe
end

