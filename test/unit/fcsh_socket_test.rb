require 'test_helper'

class FCSHSocketTest < Test::Unit::TestCase
  include Sprout::TestHelper

  context "a new fcsh server" do

    setup do
      # Uncomment to see output:
      #Sprout.stdout = $stdout
      #Sprout.stderr = $stderr

      @input = File.join(fixtures, 'mxmlc', 'simple', 'SomeFile.as')
    end

    should "be instantiable" do
      service_ready = false
      # Create the remote side of the connection:
      t = Thread.new do
        Thread.current.abort_on_exception = true
        server = FlashSDK::FCSHSocket.new
        service_ready = true
        server.listen
      end

      # Wait for the remote connection to exist
      while !service_ready
        sleep 0.1
      end

      sleep 2.0
      
      mxmlc = FlashSDK::MXMLC.new
      mxmlc.input = @input

      client = FlashSDK::FCSHSocket.new
      client.execute "mxmlc #{mxmlc.to_shell}"
      FileUtils.touch @input
      client.execute "mxmlc #{mxmlc.to_shell}"
      client.execute "quit"

      t.join
    end
  end
end

