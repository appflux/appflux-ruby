module AppfluxRuby
  module MessageBuilders
    class DelayedJob

      def initialize options
        @options = options
      end

      def to_hash
        _handler_object = YAML.load(@options['handler'])
        @options[:dj_handler] = _handler_object.inspect
        @options[:object] = _handler_object.object.inspect

        @options[:method_name] = _handler_object.method_name
        @options[:method_arguments] = _handler_object.args
        @options[:display_name] = _handler_object.display_name

        @options
      end

      def self.to_hash options
        new(options).to_hash
      end
    end
  end
end
