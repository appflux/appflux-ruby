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
        rescue Exception => e
          puts 'GNotifying Agent with e, env'
          ::Gnotifier::BugfluxNotifier.notify(e, env)
          raise e
        end
      end
    end
  end
end
