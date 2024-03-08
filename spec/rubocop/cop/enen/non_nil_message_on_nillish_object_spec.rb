# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Enen::NonNilMessageOnNillishObject, :config do
  let(:config) { RuboCop::Config.new }

  it 'registers an offense when using `#bad_method`' do
    expect_offense(<<~RUBY)
      person = "bob"
      person.bad_method
      ^^^^^^^^^^^^^^^^^ Enen/NonNilMessageOnNillishObject: You did not use the nn_ prefix
    RUBY
  end

  it 'does not register an offense when using `#good_method`' do
    expect_no_offenses(<<~RUBY)
      nn_person = "bob"
      nn_person.bad_method
    RUBY
  end
end
