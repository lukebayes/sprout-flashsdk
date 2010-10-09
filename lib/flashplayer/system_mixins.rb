##
# Update the native System instances
# to handle FlashPlayer launching in 
# order to overcome non-cli limitations.
#
module Sprout
  module System
    
    class WinSystem
      def open_flashplayer_with exe, swf
        return Thread.new {
          system command
        }
      end
    end

    class OSXSystem
      def open_flashplayer_with exe, swf
        return Thread.new {
          require 'open3'
          @player_pid, stdin, stdout, stderr = Open3.popen3(command)
          stdout.read
        }
      end
    end

    class UnixSystem
      def open_flashplayer_with exe, swf
        return Thread.new {
          require 'open4'
          @player_pid, stdin, stdout, stderr = Open4.popen4(command)
          stdout.read
        }
      end
    end

  end
end

