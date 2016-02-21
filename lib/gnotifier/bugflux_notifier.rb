##
# This class is specific only to sending bugflux notifications. It calls
#  +MessageBuilder+ class for building the payload message and uses SSL to send
#  the messages. It also implements a basic queue to send messages in batches.
#  This is the default behaviour.

require 'typhoeus'

module Gnotifier
  class BugfluxNotifier

    class << self

      def notify exception, environment = Hash.new
        request = build_request(exception, environment)
        request.run
        # Support SSL
      end

      def build_request exception, environment
        notice = Gnotifier::MessageBuilders::Bugflux.new(exception, environment).build
        request = Typhoeus::Request.new(
          ::Gnotifier::Bugflux.config.host,
          method: :post,
          body: notice,
          headers: { Accept: "text/html" }
          )
      end
    end
  end
end
