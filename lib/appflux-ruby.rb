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

if defined?(::Delayed)
  require_relative 'appflux-ruby/delayed_job/plugin'
  require_relative 'appflux-ruby/message_builders/delayed_job'
end

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
