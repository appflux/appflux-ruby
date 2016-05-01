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
        request = build_request(exception, environment)
        response = request.run

        unless response.code == 200
          if defined?(::Rails)
            ::Rails.logger.fatal("[Bugflux-Failed] Failed to notify Bugflux, please check with your configuration in config/initializers/bugflux.rb. Error Code: #{ response.code }")
          else
            puts "[Bugflux-Failed] Failed to notify Bugflux, please check with your configuration in config/initializers/bugflux.rb. Error Code: #{ response.code }"
          end
        end
      end

      def build_request exception, environment
        notice = ::AppfluxRuby::MessageBuilders::Bugflux.new(exception, environment).build
        request = ::Typhoeus::Request.new(
          ::AppfluxRuby::Bugflux.config.host,
          method: :post,
          body: notice,
          headers: { Accept: "application/json" }
          )
      end
    end
  end
end
