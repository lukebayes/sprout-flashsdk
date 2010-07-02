
module FlashPlayer

  class Trust

    attr_accessor :logger

    def initialize
      @logger = $stdout
    end

    def add path
      file = trust_file
      create(file) unless File.exists?(file)
      update_if_necessary file, path
    end

    private

    def create file
      dir = File.dirname file
      FileUtils.makedirs(dir) unless File.exists?(dir)
      FileUtils.touch file
    end

    def update_if_necessary file, path
      path = File.expand_path path
      if(!has_path?(file, path))
        File.open(file, 'a') do |f|
          f.puts path
        end
        logger.puts ">> Added #{path} to Flash Player Trust file at: #{file}"
      end
    end

    def has_path? file, path
      !File.read(file).index(path).nil?
    end

    def trust_file
      FlashPlayer.trust
    end
  end
end

