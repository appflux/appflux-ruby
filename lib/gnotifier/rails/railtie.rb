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
    end
  end
end
