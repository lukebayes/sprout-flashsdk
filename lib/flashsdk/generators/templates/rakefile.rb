require 'rubygems'
require 'bundler'
require 'bundler/setup'

require 'rake/clean'
require 'flashsdk'
require 'asunit4'

##
# Set USE_FCSH to true in order to use FCSH for all compile tasks.
#
# You can also set this value by calling the :fcsh task 
# manually like:
#
#   rake fcsh run
#
# These values can also be sent from the command line like:
#
#   rake run FCSH_PKG_NAME=flex3
#
# ENV['USE_FCSH']         = true
# ENV['FCSH_PKG_NAME']    = 'flex4'
# ENV['FCSH_PKG_VERSION'] = '1.0.14.pre'
# ENV['FCSH_PORT']        = 12321

##############################
# Debug

# Compile the debug swf
mxmlc "<%= bin %>/<%= debug_swf_name %>" do |t|
  t.input = "<%= src %>/<%= class_name %>.as"
  t.debug = true
end

desc "Compile and run the debug swf"
flashplayer :run => "<%= bin %>/<%= debug_swf_name %>"

##############################
# SWC

compc "<%= bin %>/<%= class_name %>.swc" do |t|
  t.input_class = "<%= class_name %>"
  t.source_path << 'src'
end

desc "Compile the SWC file"
task :swc => '<%= bin %>/<%= class_name %>.swc'

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

task :default => :run

