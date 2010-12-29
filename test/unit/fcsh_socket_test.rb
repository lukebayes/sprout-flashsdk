require 'test_helper'

class FCSHSocketTest < Test::Unit::TestCase
  include Sprout::TestHelper

  context "a new fcsh server" do

    setup do
      #Sprout.stdout = $stdout
      #Sprout.stderr = $stderr
      @input = File.join(fixtures, 'mxmlc', 'simple', 'SomeFile.as')
    end

    should "be instantiable" do
      t = Thread.new do
        Thread.current.abort_on_exception = true
        server = FlashSDK::FCSHSocket.new
        server.listen
      end

      sleep(3)

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

