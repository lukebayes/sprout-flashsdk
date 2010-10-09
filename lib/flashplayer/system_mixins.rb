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
          system exe, swf
        }
      end
    end

    class OSXSystem < UnixSystem

      def close_flashplayer
        if @player_thread.alive?
          closer = []
          closer << "osascript"
          closer << "ext/CloseFlashPlayerForDumbassOSX.scpt"
          closer << @player_exe
          `#{closer.join(" ")}`
        end
      end

      def open_flashplayer_with exe, swf
        @player_exe = exe.split(' ').join('\ ')
        
        wrapper = []
        wrapper << "osascript"
        wrapper << "ext/OpenFlashPlayerForDumbassOSX.scpt"
        wrapper << @player_exe

        # Call the UnixSystem.open_flashplayer_with method:
        super wrapper.join(" "), File.expand_path(swf)
      end

    end

    # All others inherit from this class
    class UnixSystem

      def close_flashplayer
        # Don't need to do anything - created
        # this method to handle belligerent OS X trash.
      end

      def open_flashplayer_with exe, swf
        @player_thread = Thread.new {
          require 'open4'
          @player_pid, stdin, stdout, stderr = Open4.popen4("#{exe} #{swf}")
          stdout.read
        }
      end
    end

  end
end

