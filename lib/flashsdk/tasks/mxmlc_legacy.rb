
=begin
    def define # :nodoc:
      super

      if(!output)
        if(name.match(/.swf/) || name.match(/swc/))
          self.output = name
        end
      end
      
      if(input && !input.match(/.css/) && File.exists?(input))
        source_path << File.dirname(input)
      end
      
      if(include_path)
        include_path.each do |path|
          process_include_path(path) if(File.directory?(path))
        end
      end
      
      self.include_path = []
      
      if(link_report)
        CLEAN.add(link_report)
      end
      
      source_path.uniq!
      param_hash['source_path'].value = clean_nested_source_paths(source_path)
      
      CLEAN.add(output)
      if(incremental)
        CLEAN.add(FileList['**/**/*.cache'])
      end

      self
    end
    
    protected 
    
    def process_include_path(path)
      symbols = []
      FileList["#{path}/**/*[.as|.mxml]"].each do |file|
        next if File.directory?(file)
        file.gsub!(path, '')
        file.gsub!(/^\//, '')
        file.gsub!('/', '.')
        file.gsub!(/.as$/, '')
        file.gsub!(/.mxml$/, '')
        file.gsub!(/.css$/, '')
        symbols << file
      end
      
      symbols.each do |symbol|
        self.includes << symbol
      end
    end
    
    def clean_nested_source_paths(paths)
      results = []
      paths.each do |path|
        # TODO: This should only happen if: allow_source_path_overlap != true
        if(check_nested_source_path(results, path))
          results << path
        end
      end
      return results
    end
    
    def check_nested_source_path(array, path)
      array.each_index do |index|
        item = array[index]
        if(item =~ /^#{path}/)
          array.slice!(index, 1)
        elsif(path =~ /^#{item}/)
          return false
        end
      end
      return true
    end

    # Use the swc path if possible
    # Otherwise add to source
    def resolve_library(library_task)
      #TODO: Add support for libraries that don't get
      # copied into the project
      path = library_task.project_path
      if(path.match(/.swc$/))
        library_path << library_task.project_path
      else
        source_path << library_task.project_path
      end
    end
    
    def execute_with_fcsh(command)
      begin
        display_preprocess_message
        puts FCSHSocket.execute("mxmlc #{command}")
      rescue FCSHError => fcsh_error
        raise fcsh_error
      rescue StandardError => std_error
        # TODO: Capture a more concrete error here...
        raise MXMLCError.new("[ERROR] There was a problem connecting to the Flex Compiler SHell, run 'rake fcsh:start' in another terminal.")
      end
    end
    
    def execute(*args)
      begin
        start = Time.now.to_i
        if(@use_fcsh)
          execute_with_fcsh(to_shell)
        else
          super
        end
        Log.puts "mxmlc finished compiling #{name} in #{Time.now.to_i - start} seconds"
      rescue ExecutionError => e
        if(e.message.index('Warning:'))
          # MXMLC sends warnings to stderr....
          Log.puts(e.message.gsub('[ERROR]', '[WARNING]'))
        else
          raise e
        end
      end
    end

  end
end

# Helper method for definining and accessing MXMLC instances in a rakefile
def mxmlc(args, &block)
  AS3::MXMLC.define_task(args, &block)
end

=end

