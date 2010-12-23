
module Sprout

  module System
    
    class WinSystem
      
      def open_flashplayer_with exe, swf
        return Thread.new {
          execute exe, swf
        }
      end
    end

    class OSXSystem < UnixSystem

      ##
      # Use AppleScript to open the specified Flash Player
      # because, simply launching the executable does not focus
      # it.
      def open_flashplayer_with exe, swf
        # Clean paths differently for this exectuable,
        # because we're forking out to AppleScript over
        # a new process, and spaces need to be escaped.
        @player_exe = exe.split(' ').join('\ ')

        wrapper = []
        wrapper << "osascript"
        wrapper << open_flashplayer_script_path
        wrapper << @player_exe

        # Call the UnixSystem.open_flashplayer_with method:
        super wrapper.join(" "), File.expand_path(swf)
      end

      private

      ##
      # Use AppleScript to close the Flash Player
      def close_flashplayer
        closer = []
        closer << "osascript"
        closer << close_flashplayer_script_path
        closer << @player_exe
        `#{closer.join(" ")}`
      end

      def ext_gem_path
        File.join(File.dirname(__FILE__), '..', '..', 'ext')
      end

      def close_flashplayer_script_path
        File.expand_path(File.join(ext_gem_path, "CloseFlashPlayerForDumbassOSX.scpt"))
      end

      def open_flashplayer_script_path
        File.expand_path(File.join(ext_gem_path, "OpenFlashPlayerForDumbassOSX.scpt"))
      end

    end

    # All others inherit from this class
    class UnixSystem

      def open_flashplayer_with exe, swf
        trap("INT") { 
          close_flashplayer
          @player_thread.kill
        }

        @player_thread = Thread.new {
          require 'open4'
          @player_pid, stdin, stdout, stderr = Open4.popen4("#{exe} #{swf}")
          stdout.read
        }
      end
      
      private

      def close_flashplayer
        # Don't need to do anything - created
        # this method to handle belligerent OS X trash.
      end

    end
  end
end

