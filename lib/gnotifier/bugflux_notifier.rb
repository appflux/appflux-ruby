module Gnotifier
  class BugfluxNotifier
    class << self
      def notify(url, exception)
        ## ::TODO::
        # Send notification via net/http library -- A POST Request.
        # Support SSL
      end
    end
  end
end
