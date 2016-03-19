## TODO: Add Rack Env. Current User.
##
# This class builds payload message to send to the backyard application.
# custom_tabs appear as individual tabs on Bugflux UI and are only set per
#  exception occurrence.
# TODO: This might be Rails specific. Need to check for other Rack based
#  frameworks.
# {
#   bugflux: {
#     app_id: '',
#     env: {
#       app_env: 'staging'

#       request: {

#       },
#       params: {

#       },
#       headers: {

#       },
#       session: {

#       }
#     },
#     exception: {

#     }
#   },
#   custom_tabs: {
#     tab_1: {},
#     tab_2: {}
#   }
# }

module AppfluxRuby
  module MessageBuilders
    class Bugflux < AppfluxRuby::MessageBuilders::Base

      ENV_REQUEST_METHODS = %i( path host scheme user_agent port url ip
                                content_type request_method referrer )
      ENV_REQUEST_KEYS    = %i( SERVER_PROTOCOL SERVER_SOFTWARE )

      ENV_EXCEPTION_METHODS = %i( backtrace message cause class )

      SUPPORTED_BACKGROUND_JOB_PROCESSORS = %w(delayed_job)

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
        add_env
        add_headers
        add_session_data
        add_background_job_info
        add_custom_tabs

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

        def add_session_data
          load_session
          return unless session_loaded?

          @bugflux_notice[:env][:session]= @request.env['rack.request.cookie_hash']
        end

        def add_headers
          @bugflux_notice[:env][:headers] = Hash.new

          @rack_env.keys.grep(/^HTTP_/).each do |_key|
            @bugflux_notice[:env][:headers][_key] = @rack_env[_key]
          end

          @bugflux_notice[:env][:headers].delete('HTTP_COOKIE')
        end

        def add_params
          @bugflux_notice[:env][:params] = @request.env['action_dispatch.request.parameters']
        end

        def add_app_id
          @bugflux_notice[:app_id] = ::AppfluxRuby::Bugflux.config.app_id
        end

        def add_env
          @bugflux_notice[:env][:app_env] = ::Rails.env if defined?(::Rails)
        end

        def add_custom_tabs
          @bugflux_notice[:custom_tabs] ||= Hash.new
          @bugflux_notice[:custom_tabs].merge(::AppfluxRuby::Bugflux.additional_data)
        end

        ## Adds background processor information as a dedicated tab on the UI.
        def add_background_job_info
          if @rack_env[:component].in?(SUPPORTED_BACKGROUND_JOB_PROCESSORS)
            builder_klass_string = @rack_env[:component].classify#.constantize
            builder_klass = "::AppfluxRuby::MessageBuilders::#{ builder_klass_string }".constantize

            @bugflux_notice[:custom_tabs] ||= Hash.new
            @bugflux_notice[:custom_tabs]["#{@rack_env[:component]}".to_sym] = builder_klass.to_hash(@rack_env)
          end
        end

        private

          def load_session
            unless session_loaded?
              @session['___bugflux_dummy_key___'] ||= 'bugflux'
            end
          end

          def session_loaded?
            @session.respond_to?(:loaded?) ? @session.loaded? : true
          end
    end
  end
end
