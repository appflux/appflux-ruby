module AppfluxRuby
  module MessageBuilders
    class Sidekiq

      def initialize options
        @options = options
      end

      def to_hash
        @options
      end

      def self.to_hash options
        new(options).to_hash
      end
    end
  end
end
