# {
#   custom_tabs:{
#     tab_1: {

#     },
#     tab_2: {

#     }
#   }
# }
module Gnotifier
  module MessageBuilders
    class CustomMessage
      def initialize
        @custom_tabs = Array.new
      end

      def add_tab(tab_name, options_data = {})
        # @custom_tabs << { "#{ tab_name }": options_data }
        ::Gnotifier::Bugflux.additional_data[tab_name] = options_data
      end
    end
  end
end
