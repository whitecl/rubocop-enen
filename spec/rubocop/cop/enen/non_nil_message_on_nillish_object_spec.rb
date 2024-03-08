# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Enen::NonNilMessageOnNillishObject, :config do
  let(:config) { RuboCop::Config.new }

  # TODO: Write test code
  #
  # For example
  it 'registers an offense when using `#bad_method`' do
    expect_offense(<<~RUBY)
      person = "bob"
      person.bad_method
      ^^^^^^^^^^ Use `#good_method` instead of `#bad_method`.
    RUBY
  end

  it 'does not register an offense when using `#good_method`' do
    expect_no_offenses(<<~RUBY)
      good_method
    RUBY
  end

  it 'tells me about var naming' do
    person_1 = 'bob'
    person_2 = 'bob'
  end
end
