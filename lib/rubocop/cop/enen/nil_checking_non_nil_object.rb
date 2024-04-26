# frozen_string_literal: true

require_relative "enen-shared"

module RuboCop
  module Cop
    module Enen
      # TODO: Write cop description and example of bad / good code. For every
      # `SupportedStyle` and unique configuration, there needs to be examples.
      # Examples must have valid Ruby syntax. Do not use upticks.
      #
      # @safety
      #   Delete this section if the cop is not unsafe (`Safe: false` or
      #   `SafeAutoCorrect: false`), or use it to explain how the cop is
      #   unsafe.
      #
      # @example EnforcedStyle: bar (default)
      #   # Description of the `bar` style.
      #
      #   # bad
      #   bad_bar_method
      #
      #   # bad
      #   bad_bar_method(args)
      #
      #   # good
      #   good_bar_method
      #
      #   # good
      #   good_bar_method(args)
      #
      # @example EnforcedStyle: foo
      #   # Description of the `foo` style.
      #
      #   # bad
      #   bad_foo_method
      #
      #   # bad
      #   bad_foo_method(args)
      #
      #   # good
      #   good_foo_method
      #
      #   # good
      #   good_foo_method(args)
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
