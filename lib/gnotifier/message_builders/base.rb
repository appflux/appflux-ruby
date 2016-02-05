module Gnotifier
  module MessageBuilders
    class Base
      def initialize exception, rack_env
        @exception = exception
        @rack_env  = rack_env
        @request   = ::Rack::Request.new(rack_env)
        @session   = @request.session
        ## TODO: Probably extract this hash into a dedicated class?
        @notice    = Hash.new
      end

      def build
        @notice
      end

      def self.build exception, rack_env
        new(exception, rack_env).build
      end

    end
  end
end
