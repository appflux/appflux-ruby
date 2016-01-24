module Gnotifier
  class NoticeBuilder
    ENV_KEYS = %w( GATEWAY_INTERFACE QUERY_STRING REQUEST_METHOD REQUEST_URI 
      SERVER_NAME SERVER_PORT SERVER_PROTOCOL SERVER_SOFTWARE HTTP_CONNECTION
      HTTP_CACHE_CONTROL HTTP_ACCEPT HTTP_USER_AGENT HTTP_ACCEPT_ENCODING HTTP_ACCEPT_LANGUAGE)

    def initialize rack_env
      @rack_env = rack_env
      @request = ::Rack::Request.new(rack_env)
      @session = @request.session
      @notice = { bugflux: {} }
    end

    def build_notice exception
      add_app_id
      add_exception_data(exception)
      add_environment_data
      add_params
      @notice
    end

    private

      def add_exception_data exception
        @notice[:bugflux][:exception] = Hash.new

        @notice[:bugflux][:exception][:backtrace] = exception.backtrace
        @notice[:bugflux][:exception][:message]   = exception.message
        @notice[:bugflux][:exception][:cause]   = exception.cause
      end

      def add_environment_data
        @notice[:bugflux][:environment] = Hash.new

        @notice[:bugflux][:environment][:session] = @session if @session
      end

      def add_params
        params = @request.env['action_dispatch.request.parameters']
        @notice[:bugflux][:params] = params if params
      end

      def add_app_id
        @notice[:bugflux][:app_id] = 
      end
  end
end
