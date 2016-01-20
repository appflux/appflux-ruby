module Gnotifier
  class BugfluxConfig
    ##
    # @return [ID] Identify the application where to send the notification. This value *must* be set.
    attr_accessor :app_id

    ##
    # @return [Logger] the default logger used for debug output
    attr_accessor :logger

    ##
    # @return [String] the host, which provides the API endpoint to which
    #   exceptions should be sent
    attr_accessor :host

    ##
    # @return [String] the environment in which the application is running
    attr_reader :environment

    def initialize config = Hash.new
      # self.logger = Logger.new(STDOUT)
      
      # logger.level = Logger::WARN
      # self.app_id = config[:app_id]
      self.host = 'localhost:3000'

      # self.merge(config)
    end
  end
end
