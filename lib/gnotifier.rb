# TODO: Rename to appflux
require 'gnotifier/version'
require 'gnotifier/bugflux_config'

if defined?(::Rack)
  require 'gnotifier/rack/middleware'

  require 'gnotifier/rails/railtie' if defined?(::Rails)
end

module Gnotifier
  class Bugflux
    def self.configure
      yield(Gnotifier::BugfluxConfig.new)
    end
  end
end
