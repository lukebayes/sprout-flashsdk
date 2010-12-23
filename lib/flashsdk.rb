require 'sprout'

lib = File.expand_path File.dirname(__FILE__)
$:.unshift lib unless $:.include?(lib)

require 'flashsdk/module'
require 'flashsdk/generators/flash_helper'
require 'flashsdk/generators/class_generator'
require 'flashsdk/generators/project_generator'
require 'flashsdk/generators/flex_project_generator'
require 'flashsdk/compiler_base'
require 'flashsdk/mxmlc'
require 'flashsdk/compc'
require 'flashsdk/amxmlc'
require 'flashsdk/adt'
require 'flashsdk/adl'
require 'flashsdk/fdb'
require 'flashplayer'

##
#
# The FlashSDK is a collection of project and file generators,
# automated build tasks, external libraries, executables,
# and runtimes that make it possible to create SWF and AIR content.
#
# If you're just getting started with the FlashSDK, you'll probably
# want to read more about the following topics.
#
# = Generators
#
# The FlashSDK comes with a handful of standard generators. These
# generators should be installed into your system $PATH when you
# install the FlashSDK gem. In general, Sprout generators fall
# into one of two categories: a) Application Generators, or b) File
# Generators.
#
# Application Generators can be run from any directory on your system
# and will usually create a new folder and place a large number of
# files into that folder. These generators usually don't have any
# prerequisites in terms of where they're run.
#
# File Generators usually expect to be run within an existing project
# directory, and often have dependencies related to the type of 
# project they're run in. For example, most Class generators expect
# to find a Gemfile in the same directory where they're run.
#
# If you're interested in creating your own Generators, please see
# the {Sprout::Generator} documentation.
#
# == See Also:
#
# {FlashSDK::ClassGenerator},
# {FlashSDK::FlexProjectGenerator},
# {FlashSDK::ProjectGenerator}
#
# = Rake Tasks
#
# The FlashSDK includes a number of automated build tasks that work with
# the Rake build system.
#
# If you're not familiar with Rake, you should
# stop right now and read Martin Fowler's essay introducing it to the
# world: http://martinfowler.com/articles/rake.html
#
# == See Also:
#
# {FlashSDK::MXMLC}, 
# {FlashSDK::COMPC},
# {FlashSDK::FDB},
# {FlashSDK::ADL},
# {FlashSDK::ADT},
# {FlashPlayer::Task}
#
# = Libraries
#
# There is a growing collection of libraries that have been made available
# to Sprouts users. The first of these projects is the automated
# unit test framework, AsUnit[http://asunit.org].
#
# To include a new Sprout Library into your project, you'll need to take the
# following steps:
#
# * Add it to your Gemfile like: 
#
#    gem "asunit4", ">= 4.0.0.pre"
#
# * Add it to your Rakefile like:
#
#    library :asunit4
#
# * Add it to your Rake Task like:
#
#    mxmlc 'bin/SomeProjectRunner.swf' => :asunit4 do |t|
#      ...
#    end
#
# * From your project root, run:
#
#    bundle install
#
# If you're interested in learning more about how to _create_ new libraries,
# check out the {Sprout::Library} documentation.
#
# = Executables / Runtimes
#
# The FlasSDK also includes a number of tools that help us compile and run
# ActionScript (or AIR) applications.
#
# These executables are usually accessed via Rake, and shouldn't require
# any manual intervention, but some of you are interested in
# where these applications live and how to change how they're accessed.
#
# Following are the {Sprout::Specifications} that are included with the FlashSDK:
# 
# * {file:flashsdk/lib/flashplayer/specification.rb}
# * {file:flashsdk/lib/flex3.rb}
# * {file:flashsdk/lib/flex4.rb}
#
module FlashSDK
end
