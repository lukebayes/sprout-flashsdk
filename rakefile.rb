require 'rubygems'
require 'bundler'

Bundler.require

require 'rake'
require 'rake/clean'
require 'rake/testtask'

require File.join(File.dirname(__FILE__), 'lib', 'flashsdk', 'module')

namespace :test do
  Rake::TestTask.new(:units) do |t|
    t.libs << "test/unit"
    t.test_files = FileList["test/unit/*_test.rb"]
    t.verbose = true
  end
end

desc "Run the test harness"
task :test => 'test:units'

file 'pkg' do
  FileUtils.makedirs 'pkg'
end

gem_package = "flashsdk-#{FlashSDK::VERSION}.gem"

file "pkg/#{gem_package}" => [:clean, 'pkg'] do
  sh "gem build flashsdk.gemspec"
  FileUtils.mv gem_package, "pkg/#{gem_package}"
end

desc "Create the gem package"
task :package => "pkg/#{gem_package}"

CLEAN.add gem_package
CLEAN.add 'pkg'

