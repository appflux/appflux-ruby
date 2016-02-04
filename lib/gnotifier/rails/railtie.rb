module Gnotifier
  module Rails
    class Railtie < ::Rails::Railtie
      initializer('gnotifier.middleware') do |app|
        if ::Rails.version =~ /\A5\./
          app.config.middleware.insert_after(
            ActionDispatch::DebugExceptions, Gnotifier::Rack::Middleware
          )
        else
          app.config.middleware.insert_after(
            ActionDispatch::DebugExceptions, 'Gnotifier::Rack::Middleware'
          )
        end
      end

      initializer('gnotifier.active_record') do
        ActiveSupport.on_load(:active_record) do
          require 'gnotifier/rails/active_record'
          include Gnotifier::Rails::ActiveRecord
        end
      end

    end
  end
end
