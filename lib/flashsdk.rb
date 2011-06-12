require 'sprout'

lib = File.expand_path File.dirname(__FILE__)
$:.unshift lib unless $:.include?(lib)

require 'rake/dsl'
require 'benchmark'
require 'flashsdk/module'
require 'flashsdk/generators/flash_helper'
require 'flashsdk/generators/class_generator'
require 'flashsdk/generators/project_generator'
require 'flashsdk/generators/flex_project_generator'
require 'flashsdk/fcsh'
require 'flashsdk/fcsh_socket'
require 'flashsdk/compiler_base'
require 'flashsdk/asdoc'
require 'flashsdk/mxmlc'
require 'flashsdk/compc'
require 'flashsdk/amxmlc'
require 'flashsdk/adt'
require 'flashsdk/adl'
require 'flashsdk/fdb'
require 'flashplayer'

