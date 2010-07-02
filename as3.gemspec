# -*- encoding: utf-8 -*-
lib = File.expand_path File.join(File.dirname(__FILE__), 'lib')
$:.unshift lib unless $:.include?(lib)

require 'rubygems'
require 'bundler'
Bundler.setup

require 'as3'

Gem::Specification.new do |s|
  s.name              = AS3::NAME
  s.version           = AS3::VERSION::STRING
  s.author            = 'Luke Bayes'
  s.email             = 'lbayes@patternpark.com'
  s.description       = 'This is the project generator for ActionScript 3.0 projects'
  s.homepage          = 'http://projectsprouts.org'
  s.rubyforge_project = 'sprout'
  s.summary           = 'Project Generator for an ActionScript 3.0 project'
  s.executable        = 'sprout-as3'
  s.files             = FileList['**/**/*'].exclude /.git|.svn|.DS_Store/
  s.add_bundler_dependencies
end

