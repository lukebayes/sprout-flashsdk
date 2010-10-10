
module FlashPlayer

  class LogFile

    attr_accessor :logger

    def initialize
      @logger = $stdout
      super
    end

    def tail thread=nil
      tail_path flashlog_path, thread
    end

    private

    def tail_path path, thread=nil
      logger.puts ">> Tailing '#{path}', press CTRL+C to quit"
      create_flashlog_at path
      clear_flashlog_at path
      read_flashlog_at path, thread
    end

    def read_flashlog_at path, thread=nil
      thread ||= fake_thread
      lines_put = 0

      while thread.alive? do
        lines_put = read_from_file path, lines_put
        logger.flush
        sleep(0.1)
      end

      logger.puts ""
      logger.puts ">> Exiting from tailing '#{path}' at user request"
    end

    def read_from_file path, lines_put
      File.open(path, 'r') do |file|
        lines_read = 0
        file.readlines.each do |line|
          if(lines_read >= lines_put)
            logger.puts "[trace] #{line}"
            logger.flush
            lines_put += 1
          end
          lines_read += 1
        end
      end unless !File.exists?(path)
      lines_put
    end

    def flashlog_path
      begin
        FlashPlayer.flashlog
      rescue FlashPlayer::PathError
        "/dev/null"
      end
    end

    def clear_flashlog_at path
      File.open(path, 'w') do |f|
        f.write('')
      end
    end

    def create_flashlog_at path
      if(!File.exists?(path))
        FileUtils.makedirs(File.dirname(path))
        FileUtils.touch(path)
      end
    end

    def fake_thread
      Thread.new do
        while true
          sleep(0.2)
        end
      end
    end

  end
end

desc "Tail the flashlog.txt and block (until CTRL+C)"
task :flashlog do
  mm_config = FlashPlayer::MMConfig.new
  mm_config.create
  reader = FlashPlayer::LogFile.new
  reader.tail 
end

