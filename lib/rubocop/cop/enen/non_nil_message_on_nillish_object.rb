# frozen_string_literal: true

require_relative "enen-shared"

module RuboCop
  module Cop
    module Enen
      # Checks for messages being sent to variables that might be nil with
      # messages that a nil object won't accept. nn_ prefixed variables
      # (variables that you guarantee are non-nil) are excluded from
      # these checks.
      #
      # @example
      #
      #   # bad
      #   person = "bob"
      #   person.capitalize
      #
      #   # good
      #   nn_person = "bob"
      #   nn_person.capitalize
      #
      class NonNilMessageOnNillishObject < Base
        include EnenShared

        MSG = 'Usage of method "%<method>s" on possibly nil variable "%<var_name>s"'

        def_node_matcher :sending_to_lvar_or_ivar?, <<~PATTERN
          (send ({ivar lvar} ...) ...)
        PATTERN

        def on_send(node)
          return unless sending_to_lvar_or_ivar?(node)

          var_name = get_var_name(node)

          return if variable_is_nn_prefixed?(var_name)

          return if NIL_CHECKING_MESSAGES.include?(node.method_name)

          add_offense(node, message: formatted_message(node.method_name, var_name))
        end
      end
    end
  end
end
