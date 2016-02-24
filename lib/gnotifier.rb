require_relative 'gnotifier/version'
require_relative 'gnotifier/bugflux_config'
require_relative 'gnotifier/bugflux_notifier'
require_relative 'gnotifier/message_builders/base'
require_relative 'gnotifier/message_builders/bugflux'
require_relative 'gnotifier/message_builders/custom_message'
require_relative 'gnotifier/helpers/util'

if defined?(::Rack)
  require_relative 'gnotifier/rack/middleware'

  if defined?(::Rails)
    require_relative 'gnotifier/rails/railtie'
    require_relative 'gnotifier/rails/controller_methods'
  end
end

require 'gnotifier/delayed_job/plugin' if defined?(::Delayed)

module Gnotifier
  class Bugflux
    class << self
      attr_accessor :config
      attr_accessor :additional_data
    end

    def self.configure &blk
      self.config = Gnotifier::BugfluxConfig.new
      yield self.config
    end

    ## These methods are used to set per-request custom data.
    def self.initialize_additional_data
      @additional_data = Hash.new
    end

  end
end
