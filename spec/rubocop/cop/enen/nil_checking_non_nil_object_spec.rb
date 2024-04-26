# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Enen::NilCheckingNonNilObject, :config do
  let(:config) { RuboCop::Config.new }

  context "when calling a method on a local variable" do
    it "registers an offense when using a nil-checking method on a prefixed variable" do
      expect_offense(<<~RUBY)
        nn_person = "bob"
        nn_person.nil?
        ^^^^^^^^^^^^^^ Enen/NilCheckingNonNilObject: Uneccessary nil checking with method "nil?" on non-nil variable "nn_person"
      RUBY
    end

    it "does not registers an offense when using a nil-checking method on a not-prefixed variable" do
      expect_no_offenses(<<~RUBY)
        person = "bob"
        person.nil?
      RUBY
    end
  end

  context "when calling a method on an instance variable" do
    it "registers an offense when using a nil-checking method on a prefixed variable" do
      expect_offense(<<~RUBY)
        @nn_person = "bob"
        @nn_person.nil?
        ^^^^^^^^^^^^^^^ Enen/NilCheckingNonNilObject: Uneccessary nil checking with method "nil?" on non-nil variable "@nn_person"
      RUBY
    end

    it "does not registers an offense when using a nil-checking method on a not-prefixed variable" do
      expect_no_offenses(<<~RUBY)
        @person = "bob"
        @person.nil?
      RUBY
    end
  end
end
