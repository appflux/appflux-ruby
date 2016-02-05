require_relative 'gnotifier/version'
require_relative 'gnotifier/bugflux_config'
require_relative 'gnotifier/bugflux_notifier'
require_relative 'gnotifier/message_builders/base'
require_relative 'gnotifier/message_builders/bugflux'
require_relative 'gnotifier/helpers/util'

if defined?(::Rack)
  require_relative 'gnotifier/rack/middleware'

  require_relative 'gnotifier/rails/railtie' if defined?(::Rails)
end

module Gnotifier
  class Bugflux
    class << self
      attr_accessor :config
    end

    def self.configure &blk
      self.config = Gnotifier::BugfluxConfig.new
      yield self.config
    end
  end
end
