AppfluxRuby::Bugflux.configure do |config|
  config.app_id = '<your-app-id>'
end

if defined?(::Delayed)
  require 'appflux-ruby/delayed/plugin'
  require 'appflux-ruby/message_builders/delayed_job'

  Delayed::Worker.plugins << ::AppfluxRuby::Delayed::Plugin
end
