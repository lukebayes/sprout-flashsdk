require 'test_helper'

class AsDocTest < Test::Unit::TestCase
  include Sprout::TestHelper

  context "An AsDoc tool" do

    setup do
      @original_use_fcsh_value = ENV['USE_FCSH']
      @fixture                 = File.join fixtures, 'asdoc'
      @source_path             = File.join @fixture, 'src'
      @lib_path                = File.join @fixture, 'lib'
      @doc_output              = File.join @fixture, 'docs'

      @swf_input               = File.join @fixture, 'src', 'SomeFile.as'
      @swf_output              = File.join @fixture, 'bin', 'SomeFile.swf'
    end

    teardown do
      remove_file @doc_output
    end

    should "generate simple documentation" do
      t = FlashSDK::AsDoc.new
      t.doc_sources << @source_path
      t.doc_sources << @lib_path
      t.output = @doc_output
      t.expects(:execute)
      t.execute

      assert_file @doc_output
    end

=begin
    should "work with a rake task too" do
      exe = asdoc @doc_output do |t|
        t.doc_sources << @source_path
        t.doc_sources << @lib_path
      end
      exe.execute
    end
=end

  end
end

