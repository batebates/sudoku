# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'class/TEST.rb'
  test.verbose = true
end

#desc "Code coverage detail"
#task :simplecov do
#  ENV['COVERAGE'] = "true"
#  Rake::Task['test'].execute
#end

#task :default => :test

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "Sudoku #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('class/*.rb')
end