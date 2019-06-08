AppfluxRuby::Bugflux.configure do |config|
  config.app_id = '<your-app-id>'
  config.ignored_environments = %w( test development )
end

if defined?(::Delayed)
  require 'appflux_ruby/delayed/plugin'
  require 'appflux_ruby/message_builders/delayed_job'

  Delayed::Worker.plugins << ::AppfluxRuby::Delayed::Plugin
end

if defined?(::Sidekiq)
  require 'appflux_ruby/sidekiq/error_handler'
  require 'appflux_ruby/message_builders/sidekiq'

  Sidekiq.configure_server do |config|
    config.server_middleware do |chain|
      chain.add(AppfluxRuby::Sidekiq::ErrorHandler)
    end
  end

end
