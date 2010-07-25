require 'rubygems'
require 'bundler'
Bundler.require

##############################
# Debug

# Compile the debug swf
mxmlc "bin/Flex-debug.swf" do |t|
  t.input = "src/Flex.as"
  t.debug = true
end

desc "Compile and run the debug swf"
flashplayer :debug => "bin/Flex-debug.swf"

##############################
# Test

library :asunit4

# Compile the test swf
mxmlc "bin/Flex-test.swf" => :asunit4 do |t|
  t.input = "src/FlexRunner.as"
  t.debug = true
end

desc "Compile and run the test swf"
flashplayer :test => "bin/Flex-test.swf"

task :default => :debug

