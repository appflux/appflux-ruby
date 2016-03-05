module AppfluxRuby
  module Rails
    class Railtie < ::Rails::Railtie
      initializer('appflux-ruby.middleware') do |app|
        if ::Rails.version =~ /\A5\./
          app.config.middleware.insert_after(
            ActionDispatch::DebugExceptions, AppfluxRuby::Rack::Middleware
          )
        else
          app.config.middleware.insert_after(
            ActionDispatch::DebugExceptions, 'AppfluxRuby::Rack::Middleware'
          )
        end
      end

      initializer('appflux-ruby.active_record') do
        ActiveSupport.on_load(:active_record) do
          require 'appflux-ruby/rails/active_record'
          include AppfluxRuby::Rails::ActiveRecord
        end
      end

    end
  end
end
