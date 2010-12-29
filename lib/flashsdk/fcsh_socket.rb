
module FlashSDK

  ##
  # This is a client to the long-running FCSH process.
  #
  # The server side of this connection should be
  # started before starting the client.
  #
  # To do this, just open a new terminal, cd into your
  # project directory, and run:
  #
  #   rake fcsh:start
  # 
  class FCSHSocket

    ##
    # The default TCP port that FCSH will use
    # to connect.
    DEFAULT_PORT = 12321

    attr_accessor :port

    attr_reader :requests

    ##
    # Create a new FCSHClient
    def initialize
      @port = DEFAULT_PORT
      @requests = {}
    end

    def listen pkg_name=nil, pkg_version=nil, port=nil
      port = port || @port
      # Instantiate FCSH:
      fcsh             = FlashSDK::FCSH.new
      fcsh.pkg_name    = pkg_name unless pkg_name.nil?
      fcsh.pkg_version = pkg_version unless pkg_version.nil?

      # Notify the outer shell that we're ready:
      Sprout.stdout.puts "FCSH socket open with: #{fcsh.pkg_name} and #{fcsh.pkg_version}, waiting for connections on port #{port}"
      Sprout.stdout.puts ""

      # Start up the FCSH Daemon:
      fcsh.execute false

      # Create a readable IO pipe:
      output = Sprout::OutputBuffer.new
      # Associate the IO pipe with our 
      # outputs so that FCSH will write
      # to it.
      Sprout.stdout = output
      Sprout.stderr = output

      server = TCPServer.new 'localhost', port

      # Create a thread that will exit
      # when FCSH exits.
      t = Thread.new do
        fcsh.wait
      end

      while t.alive? do
        Sprout.stdout.puts ""
        session  = server.accept
        rendered = render_request session.gets
        parts    = rendered.split(" ")
        method   = parts.shift.strip
        if parts.size > 0
          fcsh.send method, parts.join(" ")
        else
          fcsh.send method
        end

        if method == "clear"
          clear_requests
        end

        response = output.read
        session.puts response.gsub(fcsh.prompt, "\n")
        session.flush
        session.close
      end
    end

    def execute command, port=nil
      start = Time.now
      port = port || @port
      begin
        session = TCPSocket.new 'localhost', port
        session.puts command
        response = session.read
        if response.match /Error/
          raise Sprout::Errors::UsageError.new "[FCSH] #{response}"
        else
          Sprout.stdout.puts "[FCSH] #{response}"
        end
        response
      rescue Errno::ECONNREFUSED => e
        message = "[ERROR] "
        message << e.message
        message << ": Could not connect to an FCSH server on port: #{port} at: #{Dir.pwd}.\n\n"
        message << "This is probably because one has not been started. To start a new FCSH server, open a new "
        message << "terminal and run the following:\n\n"
        message << "cd #{Dir.pwd}\n"
        message << "rake fcsh:start\n"
        raise Sprout::Errors::UsageError.new message
      ensure
        if !session.nil? && !session.closed?
          session.flush
          session.close
        end
      end
      Sprout.stdout.puts "[FCSH] Compilation complete in #{(Time.now - start).seconds} seconds."
    end

    private

    def render_request request
      hash = Digest::MD5.hexdigest request
      if request.match /^mxmlc|^compc/
        if requests[hash].nil?
          requests[hash] = requests.size + 1
          request
        else
          "compile #{requests[hash]}"
        end
      else
        request
      end
    end

    def clear_requests
      # Clear the cached requests,
      # but leave them in place, the underlying
      # FCSH implementation continues incrementing
      # indices.

      new_requests = {}
      @requests.each_key do |key|
        new_requests["removed-item"] = "removed-item"
      end
      @requests = new_requests
    end

  end
end

