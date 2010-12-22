require "rubygems"
require "bundler"

Bundler.setup :default, :development

require 'sprout'
# These require statments *must* be in this order:
# http://bit.ly/bCC0Ew
# Somewhat surprised they're not being required by Bundler...
require 'shoulda'
require 'mocha'

$:.unshift File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'lib'))
$:.unshift File.expand_path(File.join(File.dirname(__FILE__), '..'))
require 'flashsdk'
require 'sprout/test/sprout_test_case'


module SproutTestCase

  ##
  # Update the Sprout::Executable registry so that subsequent
  # requests for an executable return a fake one instead of
  # the real one.
  # @param exe [Symbol] The executable that will be sent to the load request (e.g. :fdb, :mxmlc, etc.).
  # @param fake_name [String] The path to the fake executable that should be used.
  def insert_fake_executable fake
    # Comment the following and install the flashsdk gem
    # to run test against actual executables instead of fakes:
    path_response = OpenStruct.new(:path => fake)
    Sprout::Executable.expects(:load).returns path_response
  end
end

