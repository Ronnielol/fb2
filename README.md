# Fb2

[FictionBook](https://en.wikipedia.org/wiki/FictionBook) parser.


## Installation

Add this line to your application's Gemfile:

```.bash
gem 'fb2'
```

## Usage

```.ruby
require 'open-uri'

file = open("https://raw.githubusercontent.com/localhots/fb2/master/test/fixtures/sample.fb2")

Fb2::Book.new(file).elements
# => #<Enumerator::Lazy: #<Enumerator: #<Enumerator::Generator:0x007fa3ebb0b5f8>:each>>

Fb2::Book.new(file).body
# => #<Enumerator::Lazy: #<Enumerator::Lazy: #<Enumerator: #<Enumerator::Generator:0x007fa3edc5f420>:each>>:select>

Fb2::Book.new(file).description
# =>  #<Fb2::Description:0x007fa3edc452c8 @title ... >
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/fb2.

