# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Enen::NonNilMessageOnNillishObject, :config do
  let(:config) { RuboCop::Config.new }

  it 'registers an offense when not using the nn prefix and a non-nil method' do
    expect_offense(<<~RUBY)
      person = "bob"
      person.capitalize
      ^^^^^^^^^^^^^^^^^ Enen/NonNilMessageOnNillishObject: Usage of method "capitalize" does not exist on nil on possibly nil variable "person"
    RUBY
  end

  it 'does not register an offense when not using the nn prefix and a nil method' do
    expect_no_offenses(<<~RUBY)
      person = "bob"
      person.nil?
    RUBY
  end

  it 'does not register an offense when using the nn prefix' do
    expect_no_offenses(<<~RUBY)
      nn_person = "bob"
      nn_person.capitalize
    RUBY
  end
end
