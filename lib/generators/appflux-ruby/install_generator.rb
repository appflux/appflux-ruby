module AppfluxRuby
  class InstallGenerator < ::Rails::Generators::Base
    source_root File.expand_path("../", __FILE__)

    def create_bugflux_initializer
      copy_file 'bugflux.rb', 'config/initializers/bugflux.rb'
    end

  end
end
