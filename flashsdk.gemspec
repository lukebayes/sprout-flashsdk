# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'bundler'
require 'flashsdk/module.rb'

Gem::Specification.new do |s|
  s.name                 = 'flashsdk'
  s.version              = FlashSDK::VERSION
  s.author               = "Luke Bayes"
  s.email                = "projectsprouts@googlegroups.com"
  s.homepage             = "http://www.adobe.com/products/flex"
  s.summary              = "Adobe Flash SDK including mxmlc, compc, asdoc, adl, adt, optimizer and fdb"
  s.description          = "The Flash SDK Rubygem is brought to you by Project Sprouts (http://projectsprouts.org)"
  s.executables          =  ['sprout-as3', 'sprout-flex', 'flashplayer', 'flashlog']
  s.post_install_message = File.read 'POSTINSTALL.rdoc'
  s.files                = Dir['**/*']
  s.files.reject!          { |fn| fn.match /.git|.svn|.DS_Store/ }
  s.add_dependency('sprout', '>= 1.1.15.pre')
  s.add_development_dependency "shoulda"
  s.add_development_dependency "mocha"
  s.add_development_dependency "rake"
  s.require_paths << 'lib'
end

