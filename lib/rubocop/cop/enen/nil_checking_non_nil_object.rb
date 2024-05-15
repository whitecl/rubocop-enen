# frozen_string_literal: true

require_relative "enen-shared"

module RuboCop
  module Cop
    module Enen
      # Checks for unneccessary nil-checking of variables whose
      # names have the nn_ prefix.
      #
      # @example
      #
      #   # bad
      #   nn_person = "bob"
      #   nn_person.nil?
      #
      #   # good
      #   person = nil
      #   person.nil?
      #
      class NilCheckingNonNilObject < Base
        include EnenShared

        MSG = 'Uneccessary nil checking with method "%<method>s" on non-nil variable "%<var_name>s"'

        def_node_matcher :sending_to_lvar_or_ivar?, <<~PATTERN
          (send ({ivar lvar} ...) ...)
        PATTERN

        def on_send(node)
          return unless sending_to_lvar_or_ivar?(node)

          var_name = get_var_name(node)

          return unless variable_is_nn_prefixed?(var_name)

          if NIL_CHECKING_MESSAGES.include?(node.method_name)
            add_offense(node, message: formatted_message(node.method_name, var_name))
          end
        end
      end
    end
  end
end
