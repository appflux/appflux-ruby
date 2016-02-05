module Gnotifier
  module Rack
    class Middleware
      def initialize(app)
        @app = app
      end

      ##
      # Intercepts exception and sends notification to API.
      def call(env)
        begin
          response = @app.call(env)
        rescue Exception => ex
          puts 'GNotifying Agent with ex, env'
          ::Gnotifier::BugfluxNotifier.notify(ex, env)
          raise ex
        end
      end
    end
  end
end
