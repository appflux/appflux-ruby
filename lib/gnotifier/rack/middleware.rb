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
          Gnotifier::Bugflux.initialize_additional_data
          response = @app.call(env)
        rescue Exception => ex
          # TODO: Need to figure out a logger implementation.
          puts 'Sending exception notification to bugflux.'
          ::Gnotifier::BugfluxNotifier.notify(ex, env)
          raise ex
        end
      end
    end
  end
end
