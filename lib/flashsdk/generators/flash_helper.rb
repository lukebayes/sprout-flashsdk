
module FlashSDK

  module FlashHelper

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
      parts.pop.camel_case
    end

    def input_in_parts
      provided_input = input
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
  end
end

