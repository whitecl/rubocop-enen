# frozen_string_literal: true

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
      class NonNilMessageOnNillishObject < Base
        # TODO: Implement the cop in here.
        #
        # In many cases, you can use a node matcher for matching node pattern.
        # See https://github.com/rubocop/rubocop-ast/blob/master/lib/rubocop/ast/node_pattern.rb
        #
        # For example
        MSG = 'Usage of method "%<method>s" does not exist on nil on possibly nil variable "%<var_name>s"'
        PERMITTED_MESSAGES = %i[nil? blank? try].freeze

        # TODO: Don't call `on_send` unless the method name is in this list
        # If you don't need `on_send` in the cop you created, remove it.
        # RESTRICT_ON_SEND = %i[bad_method].freeze

        # @!method bad_method?(node)
        def_node_matcher :sending_to_lvar?, <<~PATTERN
          (send ({ivar lvar} ...) ...)
        PATTERN

        NOT_PREFIXED_WITH_NN_PATTERN = /^(?!@?nn_).*/.freeze
        def variable_is_not_prefixed?(var_name)
          !!(var_name =~ NOT_PREFIXED_WITH_NN_PATTERN)
        end

        def on_send(node)
          return unless sending_to_lvar?(node)

          var_name = get_var_name(node)

          return unless variable_is_not_prefixed?(var_name)

          return if PERMITTED_MESSAGES.include?(node.method_name)

          add_offense(node, message: formatted_message(node.method_name, var_name))
        end

        private

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
