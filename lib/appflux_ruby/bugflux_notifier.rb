##
# This class is specific only to sending bugflux notifications. It calls
#  +MessageBuilder+ class for building the payload message and uses SSL to send
#  the messages. It also implements a basic queue to send messages in batches.
#  This is the default behaviour.

require 'typhoeus'

module AppfluxRuby
  class BugfluxNotifier

    class << self

      def notify exception, environment = Hash.new
        if should_report_exception?
          ::Rails.logger.info('Notifying Appflux of this exception.')
          request = build_request(exception, environment)
          response = request.run

          unless response.code == 200
            if defined?(::Rails)
              ::Rails.logger.fatal("[Appflux-Failed] Failed to notify Appflux, please check with your configuration in config/initializers/appflux.rb. Error Code: #{ response.code }")
            else
              puts "[Appflux-Failed] Failed to notify Appflux, please check with your configuration in config/initializers/appflux.rb. Error Code: #{ response.code }"
            end
          end
        else
          ::Rails.logger.info("[Appflux] Skipping to notify Appflux for #{ ::Rails.env } environment.")
        end
      end

      private def build_request exception, environment
        notice = ::AppfluxRuby::MessageBuilders::Bugflux.new(exception, environment).build
        request = ::Typhoeus::Request.new(
          ::AppfluxRuby::Bugflux.config.host,
          method: :post,
          body: notice,
          headers: { Accept: "application/json" }
          )
      end

      private def should_report_exception?
        !AppfluxRuby::Bugflux.config.ignored_environments.include?(::Rails.env)
      end
    end
  end
end
