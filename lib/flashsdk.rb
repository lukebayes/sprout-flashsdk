require 'sprout'

lib = File.expand_path File.dirname(__FILE__)
$:.unshift lib unless $:.include?(lib)

require 'flashsdk/module'
require 'flashsdk/generators/flash_helper'
require 'flashsdk/generators/class_generator'
require 'flashsdk/generators/project_generator'
require 'flashsdk/compiler_base'
require 'flashsdk/mxmlc'
require 'flashsdk/compc'
require 'flashsdk/amxmlc'
require 'flashsdk/adt'
require 'flashsdk/adl'
require 'flashplayer'

