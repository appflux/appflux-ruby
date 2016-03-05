# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'appflux-ruby/version'

Gem::Specification.new do |spec|
  spec.name          = 'appflux-ruby'
  spec.version       = AppfluxRuby::VERSION
  spec.date             = Time.now.strftime('%Y-%m-%d')
  spec.authors       = ['Shubham Gupta']
  spec.email         = ['sgupta.89cse@gmail.com']

  spec.summary       = 'Ruby library for integration with https://appflux.io'
  spec.description   = <<DESC
AppfluxRuby is a ruby library for integrating your rack based applications with
https://appflux.io/bugflux. This gem provides a basic API for automatically and 
manually sending exceptions metadata from your Rack based application. The
processed exceptions data can be viewed at the error dashboard for the pproject
on Appflux. For Rails applications, you can also send custom data to the error
dashboard. It also integrates with various background job processing libraries
like Delayed Job. Raise an issue on GitHub if your's is not yet supported.
DESC

  spec.homepage      = 'https://appflux.io'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'Set to \'http://mygemserver.com\''
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.require_paths = ['lib']
  spec.files            = ['lib/appflux-ruby.rb', *Dir.glob('lib/**/*')]

  spec.add_dependency             'typhoeus', '~> 1.0.1'
  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'byebug', '~> 8.2'
end
