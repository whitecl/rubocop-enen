# frozen_string_literal: true

module RuboCop
  module Cop
    module Enen
      module EnenShared
        PREFIXED_WITH_NN_PATTERN = /^@*nn_.*/.freeze
        NIL_CHECKING_MESSAGES = %i[nil? blank? try].freeze

        def variable_is_nn_prefixed?(var_name)
          !!(var_name =~ PREFIXED_WITH_NN_PATTERN)
        end

        def get_var_name(node)
          var_name_symbol, = *node.receiver
          var_name_symbol.to_s
        end

        def formatted_message(method_name, var_name)
          format(
            self.class::MSG,
            method: method_name,
            var_name: var_name
          )
        end
      end
    end
  end
end
