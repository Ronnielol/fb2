# Fb2 [![Build Status](https://travis-ci.org/zinenko/fb2.svg?branch=master)](https://travis-ci.org/zinenko/fb2)

[FictionBook](https://en.wikipedia.org/wiki/FictionBook) parser / reader.

- genereted by [FictionBook2.xsd](http://gribuser.ru/xml/fictionbook/2.0/xsd/FictionBook2.xsd) - every XS type implement to Ruby class.
- for testing use [http://www.gribuser.ru/xml/fictionbook/2.0/example.fb2](http://www.gribuser.ru/xml/fictionbook/2.0/example.fb2).

## Installation

Add this line to your application's Gemfile:

```.bash
gem 'fb2'
```

## Usage

```.ruby
require 'open-uri'

file = open("https://raw.githubusercontent.com/localhots/fb2/master/test/fixtures/sample.fb2")

# get all elements
Fb2::Book.new(file).elements
# => #<Enumerator::Lazy: #<Enumerator: #<Enumerator::Generator:0x007fa3ebb0b5f8>:each>>

Fb2::Book.new(file).elements.count
# => 2

# get only description elements
Fb2::Book.new(file).description
# =>  #<Fb2::Description:0x007fa3edc452c8 @title ... >

# get title info
Fb2::Book.new(file).description.title_info
# => #<Fb2::TitleInfo:0x007fbfb9971438 @genres=[ ... >

# get document info
Fb2::Book.new(file).description.document_info
# => #<Fb2::DocumentInfo:0x007fbfb904fb98 @id=nil ... >

# get publish info
Fb2::Book.new(file).description.publish_info
# => #<Fb2::PublishInfo:0x007fbfb936bf70 ... >

# get custom info
Fb2::Book.new(file).description.custom_info
# => nil

# get only body sections
Fb2::Book.new(file).bodies
# => #<Enumerator::Lazy: #<Enumerator::Lazy: #<Enumerator: #<Enumerator::Generator:0x007fa3edc5f420>:each>>:select>

# get first body element
Fb2::Book.new(file).bodies.first
# =>  #<Fb2::Body:0x007fbfbac45cd0 @name=nil, ... >

# get text in first body element
Fb2::Book.new(file).bodies.first.text
# [#<Fb2::Title:0x007fbfb93d6d70 @text=[#<Fb2::Paragraph:0x007fbfb93d4e58 @id=nil, @style=nil, @lang=nil, @text=[#<Fb2::Text value="John Doe">]>, #<Fb2::EmptyLine:0x007fbfb93c75c8>, #<Fb2::Paragraph:0x007fbfb93bf530 @id=nil, @style=nil, @lang=nil, @text=[#<Fb2::Text value="Fiction Book">]>], @lang=nil>, #<Fb2::Section:0x007fbfb93afd60 @id=nil, @lang=nil, @text=[#< ... >

Fb2::Book.new(file).bodies.first.text.map(&:class)
# => [Fb2::Title, Fb2::Section, Fb2::Section]

# get all binay files
Fb2::Book.new(file).binaries
# => #<Enumerator::Lazy: #<Enumerator::Lazy: #<Enumerator: ... >
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/zinenko/fb2.

