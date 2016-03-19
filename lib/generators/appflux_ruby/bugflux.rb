require 'appflux-ruby'

AppfluxRuby::Bugflux.configure do |config|
  config.app_id = '<your-app-id>'
end

Delayed::Worker.plugins << Delayed::Plugins::AppfluxRuby if defined?(::Delayed)
