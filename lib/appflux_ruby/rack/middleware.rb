module AppfluxRuby
  module Rack
    class Middleware
      def initialize(app)
        @app = app
      end

      ##
      # Intercepts exception and sends notification to API.
      def call(env)
        begin
          AppfluxRuby::Bugflux.initialize_additional_data
          response = @app.call(env)
        rescue Exception => ex
          # TODO: Need to figure out a logger implementation.
          ::AppfluxRuby::BugfluxNotifier.notify(ex, env)
          raise ex
        end
      end
    end
  end
end
