module AppfluxRuby
  module Rails
    module ControllerMethods
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def before_bugflux_notify(*methods)
          run_bugflux_callbacks(methods) do

          end
        end

        private

          def run_bugflux_callbacks(__methods)
            filtered_methods = __methods.last.is_a?(::Hash) ? __methods.pop : {}

            @@custom_message = AppfluxRuby::MessageBuilders::CustomMessage.new

            if respond_to?(:before_action)
              before_action filtered_methods do |controller|
                __methods.each do |_method|
                  controller.send(_method, @@custom_message)
                end
              end
            else
              before_filter filtered_methods do |controller|
                __methods.each do |_method|
                  controller.send(_method, @@custom_message)
                end
              end
            end
            
          end

      end
    end
  end
end
