# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'appflux_ruby/version'

Gem::Specification.new do |spec|
  spec.name          = 'appflux_ruby'
  spec.version       = AppfluxRuby::VERSION
  spec.date          = Time.now.strftime('%Y-%m-%d')
  spec.authors       = ['Shubham Gupta']
  spec.email         = ['sgupta.89cse@gmail.com']

  spec.summary       = 'Ruby library for integration with http://appflux.io'
  spec.description   = <<DESC
AppfluxRuby is a ruby library for integrating your rack based applications with
https://appflux.io/bugflux. This gem provides a basic API for automatically and 
manually sending exceptions metadata from your Rack based application. The
processed exceptions data can be viewed at the error dashboard for the project
on Appflux. For Rails applications, you can also send custom data to the error
dashboard. It also integrates nicely with Delayed Job. Raise an issue on GitHub
for any feature requests or bugs. For reporting security vulnerablities, please 
send an email at sgupta.89cse@gmail.com
DESC

  spec.homepage      = 'http://appflux.io'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- test/*`.split("\n")
  spec.require_paths = ['lib']

  spec.add_dependency             'typhoeus'
  spec.add_development_dependency 'bundler'
  # spec.add_development_dependency 'rake'
  # spec.add_development_dependency 'minitest', '~> 5.0'
  # spec.add_development_dependency 'byebug', '~> 8.2'
end
