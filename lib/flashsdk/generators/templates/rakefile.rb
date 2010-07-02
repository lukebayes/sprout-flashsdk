require 'rubygems'
require 'bundler'
Bundler.require

library :asunit4

desc "Compile the debug swf"
mxmlc "<%= bin %>/<%= debug_swf_name %>" => :asunit4 do |t|
  t.input = "<%= src %>/<%= class_name %>.as"
  t.debug = true
end

desc "Compile and run the debug swf"
flashplayer :debug => "<%= bin %>/<%= debug_swf_name %>"

task :default => :debug

