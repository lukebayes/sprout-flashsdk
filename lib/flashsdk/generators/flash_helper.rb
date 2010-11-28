
module FlashSDK

  module FlashHelper
    
    def package_directory
      split_package package
    end

    def package_name
      remove_slashes package
    end
    
    def context_package
      if package_name != ""
        return package_name + ".*"
      end
      "*"
    end
    
    def remove_slashes(value)
      if value.include?('/')
        value = value.split('/').join('.')
      end
      return value
    end
    
    def split_package(value) 
      value.split('.')
    end
    
    def test_class_directory
      parts = input_in_parts
      if parts.size > 1
        parts.pop
        return File.join test, *parts
      end
      return test
    end

    # Glob that is used to search for test cases and build
    # up the test suites
    def test_glob
      return @test_glob ||= File.join(path, test, '**', '?*Test.as')
    end

    def test_glob= glob
      @test_glob = glob
    end

    # Collection of all test case files either assigned or found
    # using the test_glob as provided.
    def test_cases
      @test_cases ||= Dir.glob(test_glob)
    end

    def test_cases= collection
      @test_cases = collection
    end

    # Get the list of test_cases (which are files) as a
    # list of fully qualified class names
    def test_case_classes
      classes = self.test_cases.dup
      classes.collect do |file|
        actionscript_file_to_class_name(file)
      end
    end

    # Transform a file name in the source or test path
    # to a fully-qualified class name
    def actionscript_file_to_class_name file
      name = file.dup
      name.gsub!(/^#{path}\//, '')
      name.gsub!(/^#{test}\//, '')
      name.gsub!(/^#{src}\//, '')
      name.gsub!(/.as$/, '')
      name.gsub!(/#{File::SEPARATOR}/, '.')
      return name
    end

    def class_directory
      parts = input_in_parts
      if parts.size > 1
        parts.pop
        return File.join src, *parts
      end
      return src
    end

    def package_name
      parts = input_in_parts
      if parts.size > 1
        parts.pop
        return "#{parts.join('.')} "
      end
      return ""
    end

    def class_name
      parts = input_in_parts
      name = parts.pop.camel_case
      if(name.match(/Test$/))
        return name.gsub(/Test$/, '')
      end
      name
    end

    def test_class_name
      source = class_name
      if(!source.match(/Test$/))
        return "#{source}Test"
      end
      source
    end

    def project_name
      input.camel_case
    end

    def instance_name
      # TODO: should uncapitalize class_name
      # (not the same as lowercase)
      # If the name is > 12 character, just
      # use 'instance' instead.
      'instance'
    end

    def input_in_parts
      provided_input = input.dup
      if provided_input.include?('/')
        provided_input.gsub! /^#{src}\//, ''
        provided_input = provided_input.split('/').join('.')
      end

      provided_input.gsub!(/\.as$/, '')
      provided_input.gsub!(/\.mxml$/, '')
      provided_input.gsub!(/\.xml$/, '')

      provided_input.split('.')
    end

    def fully_qualified_class_name
      input
    end

    def deploy_swf_name
      "#{class_name}.swf"
    end

    def debug_swf_name
      "#{class_name}-debug.swf"
    end

    def test_swf_name
      "#{class_name}-test.swf"
    end

    def test_runner_name
      "#{class_name}Runner"
    end

  end
end
