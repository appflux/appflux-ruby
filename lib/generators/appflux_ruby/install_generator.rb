module AppfluxRuby
  class InstallGenerator < ::Rails::Generators::Base
    source_root File.expand_path("../", __FILE__)

    def create_bugflux_initializer
      copy_file 'appflux.rb', 'config/initializers/appflux.rb'
    end

  end
end
