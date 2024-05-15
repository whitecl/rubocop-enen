# Rubocop::Enen

Adds duck-typed optionals to Ruby via rubocop

This is an experimental implementation of an untested idea. **Don't use this!**

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add rubocop-enen --require=false

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install rubocop-enen

## Usage

rubocop-enen provides a path to documenting optionality in your ruby project. Just prefix any variable with `nn_` to mark it as non-nil. Other variables are assumed to be possibly nil.

rubocop-enen will error on any attempt to treat a non-prefixed variable as non-nil. It will also error on treating a prefixed variable as possibly nil.

Good:

```
nn_person = "bob"
nn_person.capitalize
```

Bad:

```
person = "bob"
person.capitalize
```

Also Bad:

```
nn_person = "bob"
nn_person.nil?
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/rubocop-enen. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/rubocop-enen/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
