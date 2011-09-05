module FlashSDK
  
  ##
  # This is the abstract base class that defines common fields for ActionScript compilers like {FlashSDK::MXMLC} and {FlashSDK::COMPC}.
  #
  # Examples provided below will assume {MXMLC} is being used, but should generally be applicable for any subclass.
  #
  # @abstract
  #
  class CompilerBase < Sprout::Executable::Base

    ##
    # Enables accessibility features when compiling the Flex application or SWC file. The default value is false.
    #
    #   desc "Compile the Application"
    #   mxmlc 'bin/SomeProject.swf' do |t|
    #     t.input = 'src/SomeProject.as'
    #     t.source_path << 'src'
    #     t.accessible = true
    #   end
    #
    add_param :accessible, Boolean, { :hidden_value => true }
    
    ##
    # Sets the file encoding for ActionScript files.
    #
    add_param :actionscript_file_encoding, String
    
    ##
    # Checks if a source-path entry is a subdirectory of another source-path entry. It helps make the package names of MXML components unambiguous. 
    #
    #   desc "Compile the Application"
    #   mxmlc 'bin/SomeProject.swf' do |t|
    #     t.input = 'src/SomeProject.as'
    #     t.source_path << 'src'
    #     t.source_path << 'src/com/foo'
    #     t.allow_source_path_overlap = true
    #   end
    #
    add_param :allow_source_path_overlap, Boolean, { :hidden_value => true }

    ##
    # Use the ActionScript 3.0 class-based object model for greater performance and better error reporting. In the class-based object model, most built-in functions are implemented as fixed methods of classes.
    #
    # Setting this value to false will switch the compiler into a more ECMA-compatible mode.
    #
    # The default value is true. If you set this value to false, you must set the es option to true.
    #
    #   desc "Compile the Application"
    #   mxmlc 'bin/SomeProject.swf' do |t|
    #     t.input = 'src/SomeProject.as'
    #     t.source_path << 'src'
    #     t.as3 = false
    #   end
    # 
    add_param :as3, Boolean, { :default => true, :show_on_false => true, :hidden_value => false, :delimiter => '=' }

    ##
    # Prints detailed compile times to the standard output. The default value is true. 
    #
    #   desc "Compile the Application"
    #   mxmlc 'bin/SomeProject.swf' do |t|
    #     t.input = 'src/SomeProject.as'
    #     t.source_path << 'src'
    #     t.benchmark = true
    #   end
    #
    add_param :benchmark, Boolean, { :default => true, :show_on_false => true, :hidden_value => false, :delimiter => '=' }

    ##
    # Sets the value of the {context.root} token in channel definitions in the flex-services.xml file. If you do not specify the value of this option, Flex uses an empty string.
    #
    add_param :context_root, Path
    
    ##
    # Sets metadata in the resulting SWF file. 
    #
    add_param :contributor, String
    
    ##
    # Sets metadata in the resulting SWF file.
    #
    add_param :creator, String
    
    ##
    # Sets metadata in the resulting SWF file.
    #
    add_param :date, String
    
    ##
    # Generates a debug SWF file. This file includes line numbers and filenames of all the source files. When a run-time error occurs, the stacktrace shows these line numbers and filenames. This information is also used by the command-line debugger and the Flex Builder debugger. Enabling the debug option generates larger SWF files.
    #
    # For the mxmlc compiler, the default value is false. For the compc compiler, the default value is true. 
    # 
    # For SWC files generated with the compc compiler, set this value to true, unless the target SWC file is an RSL. In that case, set the debug option to false.
    #
    # For information about the command-line debugger, see Using the Command-Line Debugger (http://livedocs.adobe.com/flex/2/docs/00001540.html#181846).
    #
    # Flex also uses the verbose-stacktraces setting to determine whether line numbers are added to the stacktrace.
    #
    #   desc "Compile the Application"
    #   mxmlc 'bin/SomeProject.swf' do |t|
    #     t.input = 'src/SomeProject.as'
    #     t.source_path << 'src'
    #     t.debug = true
    #   end
    #
    # @see #optimize
    # @see #verbose_stacktraces
    #
    add_param :debug, Boolean, { :hidden_value => true }
    
    ##
    # Lets you engage in remote debugging sessions with the Flash IDE.
    #
    add_param :debug_password, String
    
    ##
    # Sets the SWF background color. 
    # 
    # If you're using the Flex framework, the default background IMAGE is that sickly, horrendous, blue-green-grey gradient. 
    #
    # If you want to see the background color that you set here, you will also need to override the +backgroundImage+ property
    # in your Flex Application document.
    #
    # You can also set the background color (and other values) using the +[Embed]+ metadata directive directly in your Document Root class.
    #
    #   [SWF(width='400', height='300', backgroundColor='#ffffff', frameRate='30')]
    #
    # To set the background color from a Rake task, use the 0x notation, as the following example shows:
    #
    #   desc "Compile the Application"
    #   mxmlc 'bin/SomeProject.swf' do |t|
    #     t.input = 'src/SomeProject.as'
    #     t.source_path << 'src'
    #     t.default_background_color = '0xffcc00'
    #   end
    #
    add_param :default_background_color, String
    
    ##
    # Sets the application's frame rate. The default value is 24.
    #
    #   desc "Compile the Application"
    #   mxmlc 'bin/SomeProject.swf' do |t|
    #     t.input = 'src/SomeProject.as'
    #     t.source_path << 'src'
    #     t.default_frame_rate = 24
    #   end
    #
    add_param :default_frame_rate, Number
    
    ##
    # Defines the application's script execution limits.
    #
    # The max-recursion-depth value specifies the maximum depth of Adobe Flash Player call stack before Flash Player stops. This is essentially the stack overflow limit. The default value is 1000.
    #
    # The max-execution-time value specifies the maximum duration, in seconds, that an ActionScript event handler can execute before Flash Player assumes that it is hung, and aborts it. The default value is 60 seconds. You cannot set this value above 60 seconds.
    #
    # Example:
    #
    #   desc "Compile the Application"
    #   mxmlc 'bin/SomeProject.swf' do |t|
    #     t.input = 'src/SomeProject.as'
    #     t.source_path << 'src'
    #     # 900 is new max-recursion-depth
    #     # 20 is new max-execution-time
    #     t.default_script_limits = '900 20'
    #   end
    #
    # You can override these settings in the application.
    #
    add_param :default_script_limits, String
    
    ##
    # Defines the default application size, in pixels as a String.
    #
    # If you're using the Flex 4 SDK, these values should be comma-delimited like:
    #
    #   desc "Compile the Application"
    #   mxmlc 'bin/SomeProject.swf' do |t|
    #     t.input = 'src/SomeProject.as'
    #     t.source_path << 'src'
    #     t.default_size = '950,550'
    #   end
    #
    # If you're using the Flex 3 SDK, these values should be space-delimited like:
    #
    #   desc "Compile the Application"
    #   mxmlc 'bin/SomeProject.swf' do |t|
    #     t.input = 'src/SomeProject.as'
    #     t.source_path << 'src'
    #     t.default_size = '950 550'
    #   end
    #
    add_param :default_size, String
    
    ##
    # Defines the location of the default style sheet. Setting this option overrides the implicit use of the defaults.css style sheet in the framework.swc file.
    #
    add_param :default_css_url, Url

    ##
    # This parameter is normally called 'define' but thanks to scoping issues
    # with Sprouts and Rake, we needed to rename it and chose: 'define_conditional'.
    #
    # The format of each String value is "namespace::variable_name,value", for 
    # example, if I wanted an Environment named 'production' available to 
    # conditional compilation statements, I might do the following:
    #
    # Define a global AS3 conditional compilation definition:
    #
    #   desc "Compile the Application"
    #   mxmlc 'bin/SomeProject.swf' do |t|
    #     t.input = 'src/SomeProject.as'
    #     t.source_path << 'src'
    #     t.define_conditional << 'CONFIG::environment,production'
    #   end
    #
    # Then, in any given ActionScript class, we might add the following:
    #
    #   public static const environent:String = CONFIG::environment
    #
    # This value would be available to code at runtime where we can then
    # branch on different environments.
    #
    # We can also use IFDEF like statements to completely remove or add code based
    # on a conditional value. This is (sadly) done with Boolean conditionals as follows:
    #
    #   desc "Compile the Application"
    #   mxmlc 'bin/SomeProject.swf' do |t|
    #     t.input = 'src/SomeProject.as'
    #     t.source_path << 'src'
    #     t.define_conditional << 'CONFIG::release,true'
    #     t.define_conditional << 'CONFIG::debug,false'
    #   end
    #
    # Then, in any given ActionScript class, we might add the following:
    #
    #   CONFIG::release
    #   public function getValue():String {
    #       return value;
    #   }
    #
    #   CONFIG::debug
    #   public function getValue():String {
    #       return value + " : " + debugInfo;
    #   }
    #
    # Note how the CONFIG::[name] statement precedes an ActionScript statement, but doesn't need to enclose it brackets or anything. This can
    # go in front of any ActionScript statement (functions, classes, variables, etc).
    #
    # For more information, please read {Adobe's documentation}[http://livedocs.adobe.com/flex/3/html/compilers_21.html] on conditional compilation.
    #
    add_param :define_conditional, Strings, { :shell_name => "-define" }
    
    ##
    # Sets metadata in the resulting SWF file.
    #
    #   desc "Compile the Application"
    #   mxmlc 'bin/SomeProject.swf' do |t|
    #     t.input = 'src/SomeProject.as'
    #     t.source_path << 'src'
    #     t.description = "This SWF was built with Project Sprouts!"
    #   end
    #
    add_param :description, String
    
    ##
    # Outputs the compiler options in the flex-config.xml file to the target path; for example:
    #
    #   desc "Compile the Application"
    #   mxmlc 'bin/SomeProject.swf' do |t|
    #     t.input = 'src/SomeProject.as'
    #     t.source_path << 'src'
    #     t.dump_config = 'mxmlc-config.xml'
    #   end
    #
    # @see #load_config
    #
    add_param :dump_config, File
    
    ##
    # Use the ECMAScript edition 3 prototype-based object model to allow dynamic overriding of prototype properties. In the prototype-based object model, built-in functions are implemented as dynamic properties of prototype objects.
    #
    # You can set the strict option to true when you use this model, but it might result in compiler errors for references to dynamic properties.
    #
    # The default value is false. If you set this option to true, you must set the as3 option to false.
    #
    #   desc "Compile the Application"
    #   mxmlc 'bin/SomeProject.swf' do |t|
    #     t.input = 'src/SomeProject.as'
    #     t.source_path << 'src'
    #     t.es = true
    #     t.as3 = false
    #   end
    #
    add_param :es, Boolean
    
    ##
    # Sets a list of symbols to exclude from linking when compiling a SWF file.
    #
    # This option provides compile-time link checking for external references that are dynamically linked.
    #
    #   desc "Compile the Application"
    #   mxmlc 'bin/SomeProject.swf' do |t|
    #     t.input = 'src/SomeProject.as'
    #     t.source_path << 'src'
    #     t.externs << 'com.somedomain.SomeClass'
    #     t.externs << 'com.otherdomain.OtherClass'
    #   end
    #
    # To dynamically link against files, folders or SWCs instead of classes, see {#external_library_path}.
    #
    add_param :externs, Strings
    
    ##
    # Specifies a list of SWC files or directories to exclude from linking when compiling a SWF file. 
    #
    # This option provides compile-time link checking for external components that are dynamically linked.
    #
    #   desc "Compile the Application"
    #   mxmlc 'bin/SomeProject.swf' do |t|
    #     t.input = 'src/SomeProject.as'
    #     t.source_path << 'src'
    #     t.external_library_path << 'src/com/domain/project/SomeClass.as'
    #     t.external_library_path << 'lib/somelib/'
    #     t.external_library_path << 'lib/otherlib/OtherLibrary.swc'
    #   end
    #
    # To dynamically link against classes instead of files, folders or SWCs, see {#externs}.
    #
    add_param :external_library_path, Files
    
    ##
    # Alias for {#external_library_path}
    #
    add_param_alias :el, :external_library_path
    
    ##
    # Specifies source files to compile. This is the default option for the mxmlc compiler.
    #
    add_param :file_specs, Files
    
    ##
    # Specifies the range of Unicode settings for that language.
    #
    add_param :fonts_languages_language_range, String, { :shell_name => "-compiler.fonts.languages.language-range" }

    ##
    # Defines the font manager. The default is flash.fonts.JREFontManager. You can also use the flash.fonts.BatikFontManager.
    #
    add_param :fonts_managers, Strings, { :shell_name => "-compiler.fonts.managers" }
    
    ##
    # Sets the maximum number of fonts to keep in the server cache.
    #
    add_param :fonts_max_cached_fonts, Number, { :shell_name => "-compiler.fonts.max.cached.fonts" }
    
    ##
    # Sets the maximum number of character glyph-outlines to keep in the server cache for each font face.
    #
    add_param :fonts_max_glyphs_per_face, Number, { :shell_name => "-compiler.fonts.max.glyphs.per.face" }
    
    ##
    # Specifies a SWF file frame label with a sequence of one or more class names that will be linked onto the frame.
    #
    #   desc "Compile the Application"
    #   mxmlc 'bin/SomeProject.swf' do |t|
    #     t.input = 'src/SomeProject.as'
    #     t.source_path << 'src'
    #     t.frames_frame << 'someFrameLabel SomeClass OtherClass AnotherClass'
    #     t.frames_frame << 'anotherFrameLabel YetAnotherClass'
    #   end
    #
    add_param :frames_frame, Strings, { :shell_name => '-frames.frame' }
    
    ##
    # Toggles the generation of an IFlexBootstrap-derived loader class.
    #
    #   desc "Compile the Application"
    #   mxmlc 'bin/SomeProject.swf' do |t|
    #     t.input = 'src/SomeProject.as'
    #     t.source_path << 'src'
    #     t.generate_frame_loader = false
    #   end
    #
    # * Might be deprecated?
    #
    add_param :generate_frame_loader, Boolean
    
    ##
    # Enables the headless implementation of the Flex compiler. 
    #
    # This sets the following (in Java):
    #
    #   System.setProperty('java.awt.headless', 'true')
    #
    # The headless setting (java.awt.headless=true) is required to 
    # compile SWFs that use fonts and SVG on UNIX systems that aren't 
    # running X Windows.
    #
    add_param :headless_server, Boolean
    
    ##
    # Links all classes inside a SWC file to the resulting application SWF file, regardless of whether or not they are used.
    #
    # Contrast this option with the {#library_path} option that includes only those classes that are referenced at compile time.
    #
    # To link one or more classes whether or not they are used and not an entire SWC file, use the {#includes} option.
    #
    # This option is commonly used to specify resource bundles.
    #
    #   desc "Compile the Application"
    #   mxmlc 'bin/SomeProject.swf' do |t|
    #     t.input = 'src/SomeProject.as'
    #     t.source_path << 'src'
    #     t.include_libraries << 'lib/somelib/SomeLib.swc'
    #   end
    #
    # @see #include_path
    # @see #includes
    # @see #library_path
    #
    add_param :include_libraries, Files

    ##
    # Links one or more classes to the resulting application SWF file, whether or not those classes are required at compile time.
    #
    # To link an entire SWC file rather than individual classes, use the {#include_libraries} option.
    #
    #   desc "Compile the Application"
    #   mxmlc 'bin/SomeProject.swf' do |t|
    #     t.input = 'src/SomeProject.as'
    #     t.source_path << 'src'
    #     t.source_path << 'lib/somelib'
    #     t.includes << 'com.domain.SomeClass'
    #   end
    #
    # @see #include_libraries
    # @see #include_path
    # @see #library_path
    #
    add_param :includes, Strings
    
    ##
    # Define one or more directory paths for include processing. For each path that is provided, all .as and .mxml files found forward of that path will
    # be included in the SWF regardless of whether they are referenced elsewhere.
    #
    #   desc "Compile the Application"
    #   mxmlc 'bin/SomeProject.swf' do |t|
    #     t.input = 'src/SomeProject.as'
    #     t.source_path << 'src'
    #     t.source_path << 'lib/somelib'
    #     t.include_path << 'lib/somelib/com/somelib/net'
    #   end
    #
    # @see #include_libraries
    # @see #includes
    # @see #library_path
    #
    add_param :include_path, Paths
    
    ##
    # Enables incremental compilation.
    # 
    # This option is true by default for the Flex Builder application compiler. 
    #
    # For the command-line compiler, the default is false. 
    #
    # The web-tier compiler does not support incremental compilation.
    #
    add_param :incremental, Boolean
    
    ##
    # Keep the specified metadata in the SWF (advanced, repeatable). This parameter must be set
    # if you attempt to define new metadata tags.
    #
    # If you define metadata tags and use this parameter to include them when building a SWC,
    # consumers of your SWC library will not also need to re-include the same metadata tags.
    #
    # Following is an example Rakefile that is setting this property:
    #
    #   desc "Compile the Application"
    #   mxmlc 'bin/SomeProject.swf' do |t|
    #     t.input = 'src/SomeProject.as'
    #     t.source_path << 'src'
    #     t.keep_as3_metadata << 'Orange'
    #   end
    #
    # There could be a class somewhere that defines this metadata tag:
    #
    #   [Orange(isTasty=true)]
    #   public function eatOranges():void {
    #       // do something
    #   }
    #
    # There would normally be another class that does some kind of reflection to perform
    # some special operation on all entities that declare themselves as [Orange].
    #
    add_param :keep_as3_metadata, Strings
    
    ##
    # Determines whether to keep the generated ActionScript class files.
    #
    # The generated class files include stubs and classes that are generated by the compiler and used to build the SWF file.
    #
    # The default location of the files is the /generated subdirectory, which is directly below the target MXML file. If the /generated directory does not exist, the compiler creates one.
    #
    # The default names of the primary generated class files are filename-generated.as and filename-interface.as.
    #
    # The default value is false.
    #
    add_param :keep_generated_actionscript, Boolean
    
    ##
    # Sets metadata in the resulting SWF file.
    #
    add_param :language, String
    
    ##
    # Enables ABC bytecode lazy initialization.
    #
    # The default value is false.
    #
    add_param :lazy_init, Boolean


    ##
    # <product> <serial-number>
    #
    # Specifies a product and a serial number.  (repeatable)
    #
    add_param :license, String
    
    ##
    # Links SWC files to the resulting application SWF file. The compiler only links in those classes for the SWC file that are referenced from
    # your Document Root, or another class that it references.
    #
    # The default value of the {#library_path} option includes all SWC files in the libs directory and the current locale. These are required.
    #
    # To point to individual classes or packages rather than entire SWC files, use the {#source_path} option.
    #
    # You can use the << operator to append the new argument to the list of existing library paths:
    #
    #   desc "Compile the Application"
    #   mxmlc 'bin/SomeProject.swf' do |t|
    #     t.input = 'src/SomeProject.as'
    #     t.library_path << 'lib/somelib/SomeLib.swc'
    #   end
    #
    # If you set the value of the library_path using the '=' operator, you must set the entire Array.
    #
    # You may also need to explicitly add the framework.swc and locale SWC files. Your new entry is 
    # not appended to the {#library_path} but replaces it. Once the value has been set, you can use 
    # the '<<' operator for subsequent applications.
    #
    #   desc "Compile the Application"
    #   mxmlc 'bin/SomeProject.swf' do |t|
    #     t.input = 'src/SomeProject.as'
    #     t.source_path << 'src'
    #     t.library_path = ['lib/somelib/SomeLib.swc']
    #   end
    #
    # In a configuration file, you can set the append attribute of the library-path tag to true to indicate that the values should be appended to the library path rather than replace it.
    #
    # @see {#source_path}
    #
    add_param :library_path, Files
    
    ##
    # Alias to library_path
    #
    add_param_alias :l, :library_path
    
    ##
    # Prints linking information to the specified output file. 
    # This file is an XML file that contains 
    #
    #     <def>, <pre>, and <ext> 
    #
    # Symbols showing linker dependencies in the final SWF file.
    #
    # The file format output by this command can be used to write a file for input to the {#load_externs} option.
    #
    #   desc "Compile the Application"
    #   mxmlc 'bin/SomeProject.swf' do |t|
    #     t.input = 'src/SomeProject.as'
    #     t.source_path << 'src'
    #     t.link_report = 'ext/link-report.xml'
    #   end
    #
    # @see #load_externs
    #
    add_param :link_report, String # SHOULD be a String - File types become prerequisites.
    
    ##
    # Specifies the location of the configuration file that defines compiler options.
    #
    # If you specify a configuration file, you can still override individual options by setting them on the command line.
    #
    # All relative paths in the configuration file are relative to the location of the configuration file itself.
    # 
    #   desc "Compile the Application"
    #   mxmlc 'bin/SomeProject.swf' do |t|
    #     t.input = 'src/SomeProject.as'
    #     t.source_path << 'src'
    #     t.load_config << 'mxmlc-config.xml'
    #   end
    #
    # If you would like to see this file for your current configuration, you can set the {#dump_config} parameter and run your rake task.
    #
    # @see #dump_config
    #
    add_param :load_config, Files
    
    ##
    # Specifies the location of an XML file that contains 
    #
    #     <def>, <pre>, and <ext> 
    #
    # symbols to omit from linking when compiling a SWF file. 
    #
    # The XML file uses the same syntax as the one produced by the link-report option. 
    #
    # This option provides compile-time link checking for external components that are dynamically linked.
    #
    #   desc "Compile the Application"
    #   mxmlc 'bin/SomeProject.swf' do |t|
    #     t.input = 'src/SomeProject.as'
    #     t.source_path << 'src'
    #     t.load_externs = 'framework-link-report.xml'
    #   end
    #
    # The input for this parameter is often the output of another build task that is set up to emit a {#link_report}, 
    # for example, the previous example might be loading a {#link_report} from a task that looks like:
    #
    #   desc "Compile the Application"
    #   compc 'bin/rsls' do |t|
    #     t.directory = true
    #     t.include_sources << 'lib/framework'
    #     t.link_report = 'framework-link-report.xml'
    #   end
    #
    # @see #link_report
    #
    add_param :load_externs, File
    
    ##
    # Specifies the locale that should be packaged in the SWF file (for example, en_EN). 
    #
    # You run the mxmlc compiler multiple times to create SWF files for more than one locale, 
    # with only the locale option changing.
    #
    # You must also include the parent directory of the individual locale directories, 
    # plus the token \{locale\}, in the source-path. 
    #
    # One way to do this with Rake might be as follows:
    #
    #   # Create a new, empty task to asseble the locale-specific
    #   # build tasks:
    #   desc 'Build localized SWF files'
    #   task :build_locales
    #
    #   # For each supported locale, create a new build task:
    #   ['en_US', 'en_EN', 'es_ES'].each do |locale|
    #
    #     swf = "bin/SomeProject-#{locale}.swf"
    #
    #     mxmlc swf do |t|
    #       t.input = 'src/SomeProject.as'
    #       t.source_path << 'src'
    #       t.source_path << "locale/#{locale}"
    #       t.locale = locale
    #     end
    #
    #     # Add the localized build task as a prerequisite
    #     # to the aggregate task:
    #     task :build_locales => swf
    #   end
    #
    # If the previous code was in a Rake file, you could
    # build all localized SWFs with:
    #
    #   rake build_locales
    #
    # You could also build a single locale with:
    #
    #   rake bin/SomeProject-en_US.swf
    #
    add_param :locale, String
    
    ##
    # Sets metadata in the resulting SWF file. 
    #
    add_param :localized_description, String

    ##
    # Sets metadata in the resulting SWF file.
    #
    add_param :localized_title, String
    
    ##
    # Specifies a namespace for the MXML file. You must include a URI and the location of the manifest file that defines the contents of this namespace. This path is relative to the MXML file.
    #
    add_param :namespaces_namespace, String
    
    ##
    # Enables the ActionScript optimizer. This optimizer reduces file size and increases performance by optimizing the SWF file's bytecode, but 
    # takes slightly longer to compile. This should usually be set to true for any SWF files that are headed to production.
    #
    #   desc "Compile the Application"
    #   mxmlc 'bin/SomeProject.swf' do |t|
    #     t.input = 'src/SomeProject.as'
    #     t.source_path << 'src'
    #     t.optimize = true
    #   end
    #
    # @see #debug
    #
    add_param :optimize, Boolean, { :default => true, :show_on_false => true, :hidden_value => false, :delimiter => '=' }
    
    ##
    # Specifies the output path and filename for the resulting file. 
    #
    # If you omit this option, the compiler saves the SWF file to the 
    # directory where the target file is located. The default SWF 
    # filename matches the target filename, but with a SWF file extension. When 
    # using this option with the component compiler (compc), the output is a 
    # SWC file rather than a SWF file.
    #
    # The compiler creates extra directories based on the specified filename 
    # if those directories are not present.
    #
    # The {#mxmlc} Rake task uses a Rake::File task under the covers, and
    # will automatically set this value with the string passed into the task name.
    #
    add_param :output, File, { :file_task_name => true }
    
    ##
    # Sets metadata in the resulting SWF file. 
    #
    add_param :publisher, String

    ##
    # XML text to store in the SWF metadata (overrides metadata.* configuration) (advanced)
    #
    add_param :raw_metadata, String
    
    ##
    # Prints a list of resource bundles to input to the compc compiler to create a resource bundle SWC file. The filename argument is the name of the file that contains the list of bundles.
    #
    add_param :resource_bundle_list, File
    
    ##
    # Specifies a list of run-time shared libraries (RSLs) 
    # to use for this application. RSLs are dynamically-linked at run time.
    #
    # You specify the location of the SWF file relative to the deployment 
    # location of the application. For example, if you store a file named 
    # library.swf file in the web_root/libraries directory on the web server, 
    # and the application in the web root, you specify libraries/library.swf.
    #
    add_param :runtime_shared_libraries, Strings

    ## 
    # Alias for {#runtime_shared_libraries}
    #
    add_param_alias :rsl, :runtime_shared_libraries

    ##
    # Setting up Runtime Shared Libraries (RSLs) is extremely complicated and usually
    # not worth doing unless you're using the Flex framework.
    #
    # Following are some URLs where you might learn more about using RSLs:
    #
    # * http://www.newtriks.com/?p=802
    # * http://blogs.adobe.com/rgonzalez/2006/06/modular_applications_part_2.html
    # * http://code.google.com/p/maashaack/wiki/Metadata
    # * http://flexscript.wordpress.com/2008/11/15/using-runtime-shared-libraries-utilizing-flash-player-cache/
    # 
    # If you're not using the Flex framework, the most difficult thing you'll need to do
    # is set up a Preloader and figure out how to determine which urls to load the RSLs from.
    #
    # If you are setting up RSLs with the Flex framework, you should be able to create
    # a build task something like the following:
    #
    #   version     = '4.1.0.16076'
    #   rsls_dir    = 'lib/rsls'
    #   crossdomain = ''
    #   host        = 'http://yourdomain.com'
    #
    #   desc "Compile the Application"
    #   mxmlc "bin/SomeProject.swf" do |t|
    #     t.source_path << 'src'
    #     t.input       = 'src/SomeProject.mxml'
    #     t.pkg_version = version
    #     t.runtime_shared_library_path << "lib/framework_#{version}.swc,#{host}#{rsls_dir}/framework_#{version}.swz,#{crossdomain},#{host}#{rsls_dir}/framework_#{version}.swf"
    #     t.runtime_shared_library_path << "lib/rpc_#{version}.swc,#{host}#{rsls_dir}/rpc_#{version}.swz,#{crossdomain},#{host}#{rsls_dir}/rpc_#{version}.swf"
    #   end
    #
    add_param :runtime_shared_library_path, Strings
    
    ##
    # Alias for {#runtime_shared_library_path}
    #
    add_param_alias :rslp, :runtime_shared_library_path
    
    ##
    # Specifies the location of the services-config.xml file. This file is used by Flex Data Services.
    #
    add_param :services, File

    ##
    # Shows warnings for ActionScript classes.
    #
    # The default value is true.
    #
    #   desc "Compile the Application"
    #   mxmlc 'bin/SomeProject.swf' do |t|
    #     t.input = 'src/SomeProject.as'
    #     t.source_path << 'src'
    #     t.show_actionscript_warnings = false
    #   end
    #
    add_param :show_actionscript_warnings, Boolean, { :default => true, :show_on_false => true, :hidden_value => false, :delimiter => '=' }

    ##
    # Shows a warning when Flash Player cannot detect changes to a bound property.
    #
    # The default value is true.
    #
    #   desc "Compile the Application"
    #   mxmlc 'bin/SomeProject.swf' do |t|
    #     t.input = 'src/SomeProject.mxml'
    #     t.source_path << 'src'
    #     t.show_binding_warnings = false
    #   end
    #
    add_param :show_binding_warnings, Boolean, { :default => true, :show_on_false => true, :hidden_value => false, :delimiter => '=' }

    ##
    # Shows warnings when you try to embed a font with a family name that is the same as the operating system font name.
    # The compiler normally warns you that you are shadowing a system font. Set this option to false to disable the warnings.
    #
    # The default value is true.
    #
    #   desc "Compile the Application"
    #   mxmlc 'bin/SomeProject.swf' do |t|
    #     t.input = 'src/SomeProject.mxml'
    #     t.source_path << 'src'
    #     t.show_shadowed_device_font_warnings = false
    #   end
    #
    add_param :show_shadowed_device_font_warnings, Boolean, { :default => true, :show_on_false => true, :hidden_value => false, :delimiter => '=' }

    ##
    # Shows warnings when a type selector in a style sheet or <mx:Style> block is not used by any components in the application.
    #
    # The default value is true.
    #
    #   desc "Compile the Application"
    #   mxmlc 'bin/SomeProject.swf' do |t|
    #     t.input = 'src/SomeProject.mxml'
    #     t.source_path << 'src'
    #     t.show_unused_type_selector_warnings = false
    #   end
    #
    add_param :show_unused_type_selector_warnings, Boolean, { :default => true, :show_on_false => true, :hidden_value => false, :delimiter => '=' }
    
    ##
    # Shows deprecation warnings for Flex components. To see warnings for ActionScript classes, use the show-actionscript-warnings option.
    #
    # The default value is true.
    #
    #   desc "Compile the Application"
    #   mxmlc 'bin/SomeProject.swf' do |t|
    #     t.input = 'src/SomeProject.mxml'
    #     t.source_path << 'src'
    #     t.show_deprecation_warnings = false
    #   end
    #
    add_param :show_deprecation_warnings, Boolean, { :default => true, :show_on_false => true }
    
    ##
    # Adds directories to the source path. The compiler
    # searches directories in the source path for MXML or AS source
    # files based on import statements and type references.
    #
    # Only those files that have been referenced will be included
    # in a compiled SWF or SWC file.
    #
    # To add the contents of a SWC file to the entity search, use
    # the {#library_path} option.
    #
    # The source path is also used as the search path for the component 
    # compiler's {#includes} and {#resource_bundle_list} options.
    #
    #   desc "Compile the Application"
    #   mxmlc 'bin/SomeProject.swf' do |t|
    #     t.input = 'src/SomeProject.mxml'
    #     t.source_path << 'src'
    #     t.source_path << 'lib/othersrc'
    #     t.source_path << 'lib/anothersrc'
    #   end
    #
    add_param :source_path, Paths
    
    add_param_alias :sp, :source_path 

    ##
    # Statically link the libraries specified by the {#runtime_shared_libraries} option.
    #
    # @see #runtime_shared_libraries
    #
    add_param :static_link_runtime_shared_libraries, Boolean, { :default => true }

    ##
    # Alias for {#static_link_runtime_shared_libraries}
    #
    add_param_alias :static_rsls, :static_link_runtime_shared_libraries 
    
    ##
    # Prints undefined property and function calls; also performs compile-time type checking on assignments and options supplied to method calls.
    #
    # Turning of strict typing will essentially enable Duck-Typing in the Flash Player.
    #
    # The default value is true.
    #
    #   desc "Compile the Application"
    #   mxmlc 'bin/SomeProject.swf' do |t|
    #     t.input = 'src/SomeProject.mxml'
    #     t.source_path << 'src'
    #     t.strict = false
    #   end
    #
    add_param :strict, Boolean, { :default => true, :show_on_false => true, :hidden_value => false, :delimiter => '=' }
    
    ##
    # Specifies the version of the player the application is targeting.
    #
    # Features requiring a later version will not be compiled into the application. The minimum value supported is "9.0.0".
    #
    # Be aware that this value is a String.
    #
    #   desc "Compile the Application"
    #   mxmlc 'bin/SomeProject.swf' do |t|
    #     t.input = 'src/SomeProject.mxml'
    #     t.source_path << 'src'
    #     t.target_player = '10'
    #   end
    #
    add_param :target_player, String
    
    ##
    # Specifies a list of theme files to use with this application. Theme files can be SWC files with CSS files inside them or CSS files.
    #
    # For information on compiling a SWC theme file, see Using Styles and Themes (http://livedocs.adobe.com/flex/2/docs/00000751.html#241755) in Flex 2 Developer's Guide.
    #
    add_param :theme, Files
    
    ##
    # Sets metadata in the resulting SWF file.
    #
    add_param :title, String

    ##
    # Specifies that the current application uses network services.
    #
    # The default value is true.
    #
    # When the use-network property is set to false, the application can 
    # access the local filesystem (for example, use the XML.load() method 
    # with file: URLs) but not network services. In most circumstances, the 
    # value of this property should be true.
    #
    add_param :use_network, Boolean, { :default => true, :show_on_false => true, :hidden_value => false, :delimiter => '=' }

    ##
    # Enables resource bundles. Set to true to instruct the compiler to process the contents of the [ResourceBundle] metadata tag.
    #
    # The default value is true.
    #
    add_param :use_resource_bundle_metadata, Boolean, { :default => true, :show_on_false => true, :hidden_value => false, :delimiter => '=' }
    
    ##
    # Generates source code that includes source files and line numbers. When 
    # a run-time error occurs, the stacktrace shows these line numbers.
    #
    # Enabling this option generates larger SWF files.
    #
    # The default value is false.
    #
    # @see #debug
    #
    add_param :verbose_stacktraces, Boolean

    ##
    # Verifies the libraries loaded at runtime are the correct ones.
    #
    add_param :verify_digests, Boolean
  
    ##
    # Enables specified warnings.
    #
    add_param :warn_warning_type, Boolean
    
    ##
    # Enables all warnings. Set to false to disable all warnings. This option overrides the warn-warning_type options.
    #
    # The default value is true.
    #
    add_param :warnings, Boolean, { :default => true, :show_on_false => true, :hidden_value => false, :delimiter => '=' }

    ##
    # Set to true in order to compile with the Flex Compiler Shell (FCSH).
    #
    # You can set this value directly on a single compiler instance like:
    #
    #   mxmlc 'bin/SomeProject.swf' do |t|
    #     t.input = 'src/SomeProject.as'
    #     t.use_fcsh = true
    #   end
    #
    # This value can also be set to true by sending it into Ruby as
    # an environment variable like:
    #
    #   rake test USE_FCSH=true
    #
    # If you always want to use FCSH, you can set this value in your .bashrc
    # or .bash_profile like:
    #
    #   export USE_FCSH=true
    #
    # There is also an :fcsh helper rake task that will set this value
    # simply by executing it before your build tasks. You can do this
    # from the terminal like:
    #
    #   rake fcsh test
    #
    # Or:
    #
    #   rake fcsh debug
    #
    # Or you can make it a prerequisite to any other build task like:
    #
    #   mxmlc 'bin/SomeProject.swf' => :fcsh do |t|
    #     ...
    #   end
    #
    attr_accessor :use_fcsh

    ##
    # The FCSH port to use for connections. If you are building from
    # multiple different directories, you will need to start up the
    # FCSH servers on different ports. This can be done like:
    #
    #    rake fcsh:start FCSH_PORT=12322
    #
    # and in another terminal:
    #
    #    rake fcsh mxmlc FCSH_PORT=12322
    #
    attr_accessor :fcsh_port

    ##
    # Temporary override while waiting for integration of next version!
    # TODO: Remove this method override.
    def execute
      prepare
      super
    end

    protected

    def update_fcsh
      # Check for USE_FCSH on the environment
      # variable hash, update instance value
      # if found to be true:
      if ENV['USE_FCSH'].to_s == 'true'
        self.use_fcsh = true
      end

      if !ENV['FCSH_PORT'].nil?
        self.fcsh_port = ENV['FCSH_PORT']
      end
    end

    ##
    # Template method called by {Sprout::Executable} when
    # a {Sprout::Library} is found in the Rake::Task prerequisite list.
    #
    # @param path [File] The path within the project where the library was copied.
    #
    # @return [File] The path that was provided.
    #
    def library_added path
      if(path =~ /\.swc$/)
        self.library_path << path
      else
        self.source_path << path
      end
      path
    end

    ##
    # override
    def prepare
      update_fcsh if use_fcsh.nil?
      super
    end

    ##
    # override
    def execute_delegate
      (use_fcsh) ? execute_with_fcsh : super
    end

    def execute_with_fcsh
      client = FlashSDK::FCSHSocket.new
      client.execute "#{executable.to_s} #{to_shell}", ENV['FCSH_PORT']
    end

  end
end

