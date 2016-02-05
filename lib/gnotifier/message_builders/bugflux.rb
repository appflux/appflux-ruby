##
# This class builds payload message to send to the backyard application.
# TODO: This might be Rails specific. Need to check for other Rack based
#  frameworks.
# {
#   bugflux: {
#     app_id: '',
#     environment: {
#       request: {

#       },
#       params: {

#       },
#       session: {

#       }
#     },
#     exception: {

#     }
#   }
# }

module Gnotifier
  module MessageBuilders
    class Bugflux < Gnotifier::MessageBuilders::Base

      ENV_REQUEST_METHODS = %i( path host scheme user_agent port url ip
                                content_type request_method referrer )
      ENV_REQUEST_KEYS    = %i( SERVER_PROTOCOL SERVER_SOFTWARE )

      ENV_EXCEPTION_METHODS = %i( backtrace message cause class )

      def initialize exception, rack_env
        super(exception, rack_env)

        @notice[:bugflux] = Hash.new { |hsh, key| hsh[key] = Hash.new }
        @bugflux_notice = @notice[:bugflux]
      end

      def build
        super
        add_app_id
        add_request_data
        add_params
        add_exception_data
        # add_session_data

        @notice
      end

      def self.build exception, rack_env
        new(exception, rack_env).build
      end

      private

        def add_request_data
          @bugflux_notice[:env][:request] = Hash.new
          _req_hash = @bugflux_notice[:env][:request]

          ENV_REQUEST_METHODS.each do |_method|
            _req_hash[_method.to_sym] = @request.public_send(_method)
          end

          ENV_REQUEST_KEYS.each do |_key|
            _req_hash[_key.to_sym] = @request.env[_key.to_s]
          end
        end

        def add_exception_data
          ENV_EXCEPTION_METHODS.each do |_method|
            @bugflux_notice[:exception][_method.to_sym] = @exception.public_send(_method)
          end
        end

        # def add_session_data
        #   @bugflux_notice[:environment] = Hash.new
        #   ## Iterate over the keys and populate the hash.

        #   @bugflux_notice[:environment][:session] = @session if @session
        # end

        def add_params
          @bugflux_notice[:env][:params] = @request.env['action_dispatch.request.parameters']
        end

        def add_app_id
          @bugflux_notice[:app_id] = ::Gnotifier::Bugflux.config.app_id
        end
    end
  end
end
