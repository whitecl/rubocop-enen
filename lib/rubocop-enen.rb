# frozen_string_literal: true

require 'rubocop'

require_relative 'rubocop/enen'
require_relative 'rubocop/enen/version'
require_relative 'rubocop/enen/inject'

RuboCop::Enen::Inject.defaults!

require_relative 'rubocop/cop/enen_cops'
