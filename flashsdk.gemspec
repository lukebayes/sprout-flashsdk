# -*- encoding: utf-8 -*-
lib = File.expand_path File.dirname(__FILE__), 'lib'
$:.unshift lib unless $:.include?(lib)

require 'bundler'
Bundler.setup

require 'flashsdk'

Gem::Specification.new do |s|
  s.name        = 'flashsdk'
  s.version     = FlashSDK::VERSION
  s.author      = "Luke Bayes"
  s.email       = "projectsprouts@googlegroups.com"
  s.homepage    = "http://www.adobe.com/products/flex"
  s.summary     = "Adobe Flash SDK including mxmlc, compc, asdoc, adl, adt, optimizer and fdb"
  s.description = "The Flash SDK Rubygem is brought to you by Project Sprouts (http://projectsprouts.org)"
  s.executable  = 'sprout-as3'
  s.files       = FileList['**/**/*'].exclude /.git|.svn|.DS_Store/
  s.add_bundler_dependencies
  s.require_paths << 'lib'
end

