require_relative 'appflux-ruby/version'
require_relative 'appflux-ruby/bugflux_config'
require_relative 'appflux-ruby/bugflux_notifier'
require_relative 'appflux-ruby/message_builders/base'
require_relative 'appflux-ruby/message_builders/bugflux'
require_relative 'appflux-ruby/message_builders/custom_message'
require_relative 'appflux-ruby/helpers/util'

if defined?(::Rack)
  require_relative 'appflux-ruby/rack/middleware'

  if defined?(::Rails)
    require_relative 'appflux-ruby/rails/railtie'
    require_relative 'appflux-ruby/rails/controller_methods'
  end
end

## Requires library specific files in generators. See: generators/appflux_ruby/install_generator.
## This is important to handle if appflux-ruby is present in Gemfile before Delayed Job.

module AppfluxRuby
  class Bugflux
    class << self
      attr_accessor :config
      attr_accessor :additional_data
    end

    def self.configure &blk
      self.config = AppfluxRuby::BugfluxConfig.new
      yield self.config
    end

    ## These methods are used to set per-request custom data.
    def self.initialize_additional_data
      @additional_data = Hash.new
    end

  end
end
