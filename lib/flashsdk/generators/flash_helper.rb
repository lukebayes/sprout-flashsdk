
module FlashSDK

  ##
  # The FlashHelper is a module that can be included into any {Sprout::Generator}
  # in order to provide support for many common features.
  #
  # @example An example of how to use this helper:
  #
  #   require 'flashsdk'
  #
  #   class BigFatGenerator < Sprout::Generator::Base
  #     include FlashSDK::FlashHelper
  #
  #     ...
  #   end
  #
  module FlashHelper

    protected
    
    ##
    # @return [String] The directory of the package based on the +input+ string.
    def package_directory
      if package.include?('/')
        remove_slashes package
      end
        split_package package
    end
    
    ##
    # @param [String] A directory or path on disk with slashes like ('/')
    # @return [String] The provided value with slashes replaced by dots.
    def remove_slashes(value)
      if value.include?('/')
        value = value.split('/').join('.')
      end
      return value
    end
    
    ##
    # @param value [String] A fully-qualified package or class name (com.example.project.SomeClass)
    # @return [Array<String>] The provided package or class name split on the period.
    #   split on dots.
    def split_package(value) 
      value.split('.')
    end
    
    ##
    # @return [String] The directory for test cases that are related to the class provided by +input+
    def test_class_directory
      parts = input_in_parts
      if parts.size > 1
        parts.pop
        return File.join test, *parts
      end
      return test
    end

    ##
    # @return [String] Glob that is used to search for test cases and build
    #   up the test suites.
    def test_glob
      return @test_glob ||= File.join(path, test, '**', '?*Test.as')
    end

    # @return [String] The provided or default glob.
    def test_glob= glob
      @test_glob = glob
    end

    ##
    # @return [Array<File>] Collection of all test case files either assigned or found
    # using the test_glob as provided.
    def test_cases
      @test_cases ||= Dir.glob(test_glob)
    end

    ##
    # @param [Array<String>] Set the collection of test cases as Files on disk. 
    # @return [Array<String>] Collection of all test case files that were assigned or found.
    def test_cases= collection
      @test_cases = collection
    end

    ##
    # @return [Array<String>] Get the list of test_cases (which are files) as a
    # list of fully qualified class names.
    def test_case_classes
      classes = self.test_cases.dup
      classes.collect do |file|
        actionscript_file_to_class_name(file)
      end
    end

    ##
    # Transform a file name in the source or test path
    # into a fully-qualified class name.
    #
    # @param file [File] The path to a file on disk that is in the +src+ or +test+ folder.
    # @return [String] The fully-qualified class name.
    def actionscript_file_to_class_name file
      name = file.dup
      name.gsub!(/^#{path}\//, '') if respond_to? :path
      name.gsub!(/^#{test}\//, '') if respond_to? :test
      name.gsub!(/^#{src}\//, '') if respond_to? :src
      name.gsub!(/.as$/, '')
      name.gsub!(/#{File::SEPARATOR}/, '.')
      return name
    end

    ##
    # @return [String] The directory that contains the +input+ class.
    def class_directory
      parts = input_in_parts
      if parts.size > 1
        parts.pop
        return File.join src, *parts
      end
      return src
    end

    ##
    # @return [String] The package that provided on the command line at +--package+
    def default_package_name
      remove_slashes package
    end
    
    ##
    # @return [String] The package that was provided on the command line at +--input+
    def package_name
      parts = input_in_parts
      if parts.size > 1
        parts.pop
        return "#{parts.join('.')} "
      end
      return ""
    end

    ##
    # @return [String] The fully-qualified class name provided on the command line at +--input+.
    def class_name
      parts = input_in_parts
      name = parts.pop.camel_case
      if(name.match(/Test$/))
        return name.gsub(/Test$/, '')
      end
      name
    end

    ##
    # @return [String] The fully-qualified test class name based on the +--input+ 
    #   argument provided on the command line.
    def test_class_name
      source = class_name
      if(!source.match(/Test$/))
        return "#{source}Test"
      end
      source
    end

    ##
    # @return [String] The project name provided as +--input+ on the command line.
    #   This is probably only helpful for project generators.
    def project_name
      input.camel_case
    end

    ##
    # @return [String] Currently returns hard-coded 'instance'.
    def instance_name
      # TODO: should uncapitalize class_name
      # (not the same as lowercase)
      # If the name is > 12 character, just
      # use 'instance' instead.
      'instance'
    end

    ##
    # @param value [String] If no value is provided, will use +--input+ instead.
    # @return [Array<String>] An Array of the provided string split on slahes
    #   or dots with the file extension removed.
    def input_in_parts(value=nil)
      provided_input = value || input.dup
      provided_input.gsub! /^#{src}\//, '' if respond_to? :src
      provided_input = provided_input.split('/').join('.')

      remove_file_extensions(provided_input).split('.')
    end

    ##
    # @return [String] The fully qualified class name version of whatever was +input+.
    def fully_qualified_class_name
      remove_slashes remove_file_extensions(input)
    end
    
    ##
    # @param value [String] A string that may have a file extension.
    # @return [String] A new String with common file extensions 
    #   (.as, .mxml, .xml) removed from the provided value.
    def remove_file_extensions value
      value = value.dup
      value.gsub!(/\.as$/, '')
      value.gsub!(/\.mxml$/, '')
      value.gsub!(/\.xml$/, '')
      return value
    end

    ##
    # @return [String] The +class_name+ with '.swf' appended.
    def deploy_swf_name
      "#{class_name}.swf"
    end

    ##
    # @return [String] The +class_name+ with '-debug.swf' appended.
    def debug_swf_name
      "#{class_name}-debug.swf"
    end

    ##
    # @return [String] The +class_name+ with '-test.swf' appendend.
    def test_swf_name
      "#{class_name}-test.swf"
    end

    ##
    # @return [String] The +class_name+ with 'Runner.swf' appended.
    def test_runner_name
      "#{class_name}Runner"
    end

  end
end
