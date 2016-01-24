require 'typhoeus'

module Gnotifier
  class BugfluxNotifier
    BACKEND_HOST = 'localhost:3001'
    class << self

      def notify exception, environment
        request = build_request(exception, environment)
        request.run
        # Support SSL
      end

      def build_request exception, environment
        # url = BACKEND_HOST.join('/callbacks')
        notice = Gnotifier::NoticeBuilder.new(environment).build_notice(exception)
        request = Typhoeus::Request.new(
          BACKEND_HOST,
          method: :post,
          body: notice,
          headers: { Accept: "text/html" }
          )
      end
    end
  end
end
