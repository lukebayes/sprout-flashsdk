require 'rubygems'
require 'bundler'
Bundler.require

##############################
# Debug

# Compile the debug swf
mxmlc "<%= bin %>/<%= debug_swf_name %>" do |t|
  t.input = "<%= src %>/<%= class_name %>.mxml"
  t.debug = true
end

desc "Compile and run the debug swf"
flashplayer :debug => "<%= bin %>/<%= debug_swf_name %>"

##############################
# Test

library :asunit4

# Compile the test swf
mxmlc "<%= bin %>/<%= test_swf_name %>" => :asunit4 do |t|
  t.input = "<%= src %>/<%= test_runner_name %>.mxml"
  t.library_path << "lib/asunit4/AsUnit-4.2.2.pre.swc"
  t.source_path << "test"
  t.default_size = "900,550"
  t.debug = true
end

desc "Compile and run the test swf"
flashplayer :test => "<%= bin %>/<%= test_swf_name %>"

task :default => :debug

