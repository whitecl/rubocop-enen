# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Enen::NonNilMessageOnNillishObject, :config do
  let(:config) { RuboCop::Config.new }

  context "when calling a method on a local variable" do
    it "registers an offense when not using the nn prefix and a non-nil method" do
      expect_offense(<<~RUBY)
        person = "bob"
        person.capitalize
        ^^^^^^^^^^^^^^^^^ Enen/NonNilMessageOnNillishObject: Usage of method "capitalize" does not exist on nil on possibly nil variable "person"
      RUBY
    end

    it "does not register an offense when not using the nn prefix and a nil method" do
      expect_no_offenses(<<~RUBY)
        person = "bob"
        person.nil?
      RUBY
    end

    it "does not register an offense when using the nn prefix" do
      expect_no_offenses(<<~RUBY)
        nn_person = "bob"
        nn_person.capitalize
      RUBY
    end
  end

  context "when calling a method on an instance variable" do
    it "registers an offense when not using the nn prefix and a non-nil method" do
      expect_offense(<<~RUBY)
        class TestClass
          def test
            @person = "bob"
            @person.capitalize
            ^^^^^^^^^^^^^^^^^^ Enen/NonNilMessageOnNillishObject: Usage of method "capitalize" does not exist on nil on possibly nil variable "@person"
          end
        end
      RUBY
    end

    it "does not register an offense when not using the nn prefix and a nil method" do
      expect_no_offenses(<<~RUBY)
        class TestClass
          def test
            @person = "bob"
            @person.nil?
          end
        end
      RUBY
    end

    it "does not register an offense when using the nn prefix" do
      expect_no_offenses(<<~RUBY)
        class TestClass
          def test
            @nn_person = "bob"
            @nn_person.capitalize
          end
        end
      RUBY
    end
  end
end
