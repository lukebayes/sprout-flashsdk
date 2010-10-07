require 'rubygems'
require 'bundler'
Bundler.require

##############################
# Debug

# Compile the debug swf
mxmlc "<%= bin %>/<%= debug_swf_name %>" do |t|
  t.input = "<%= src %>/<%= class_name %>.as"
  t.debug = true
end

desc "Compile and run the debug swf"
flashplayer :debug => "<%= bin %>/<%= debug_swf_name %>"

##############################
# Test

library :asunit4

# Compile the test swf
mxmlc "<%= bin %>/<%= test_swf_name %>" => :asunit4 do |t|
  t.input = "<%= src %>/<%= test_runner_name %>.as"
  t.source_path << 'test'
  t.debug = true
end

desc "Compile and run the test swf"
flashplayer :test => "<%= bin %>/<%= test_swf_name %>"

task :default => :debug

