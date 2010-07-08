module FlashSDK

  # The MXMLC task provides a rake front end to the Flex MXMLC command line compiler.
  # This task is integrated with the LibraryTask so that if any dependencies are
  # library tasks, they will be automatically added to the library_path or source_path
  # depending on whether they provide a swc or sources.
  #
  # The entire MXMLC advanced interface has been provided here. All parameter names should be
  # identical to what is available on the regular compiler except dashes have been replaced
  # by underscores.
  #
  # The following example can be pasted in a file named 'rakefile.rb' which should be placed in
  # the same folder as an ActionScript 3.0 class named 'SomeProject.as' that extends
  # flash.display.Sprite.
  #
  #   # Create a remote library dependency on the corelib swc.
  #   library :corelib
  # 
  #   # Alias the compilation task with one that is easier to type
  #   task :compile => 'SomeProject.swf'
  #
  #   # Create an MXMLC named for the output file that it creates. This task depends on the
  #   # corelib library and will automatically add the corelib.swc to it's library_path
  #   mxmlc 'bin/SomeProject.swf' => :corelib do |t|
  #     t.input                     = 'src/SomeProject.as'
  #     t.default_size              = '800,600'
  #     t.default_background_color  = "#FFFFFF"
  #     t.library_path              << 'lib/SomeLibrary.swc'
  #     t.source_path               << 'lib/otherlib'
  #   end
  #
  # Note: Be sure to check out the features of the Executable to learn more about gem_version and preprocessor
  #
  # Interface and descriptions found here:
  # http://livedocs.adobe.com/flex/2/docs/wwhelp/wwhimpl/common/html/wwhelp.htm?context=LiveDocs_Parts&file=00001481.html
  #
  class MXMLC < CompilerBase
    include Sprout::Executable

    ##
    # Main source file to send compiler"
    # This must be the last item in this list
    add_param :input, File, { :required => true, :hidden_name => true }

    set :default_prefix, '-'

    ##
    # The default gem name is sprout-flex3sdk
    #
    set :pkg_name, 'flex4'

    ##
    # The default gem version
    #
    set :pkg_version, ">= #{VERSION}"
    
    ##
    # The default executable target
    #
    set :executable, :mxmlc

  end
end

def mxmlc args, &block
  exe = FlashSDK::MXMLC.new
  exe.to_rake(args, &block)
  exe
end

