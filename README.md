# Chicrime
[![Coverage Status](https://coveralls.io/repos/bloomyminded/chicrime/badge.svg?branch=master&service=github)](https://coveralls.io/github/bloomyminded/chicrime?branch=master)[![Build Status](https://travis-ci.org/bloomyminded/chicrime.png?branch=master)](https://travis-ci.org/bloomyminded/chicrime)

Chicrime is a ruby gem that wraps the [soda-ruby](https://github.com/socrata/soda-ruby) library with easy to use methods.  The purpose of Chicrime is to enable users to easily access
Chicago's crime [data](http://data.cityofchicago.org).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'chicrime'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install chicrime

## Usage

```ruby
chicrime = Chicrime::Dataset.new(<OPTIONAL API TOKEN>)


chicrime.where_query("ward = '1'", "beat = '1431'")
# => returns array of Hashie::Mash objects where ward = 1 and beat = 1431

chicrime.select_query(:beat)
# => returns array of Hashie::Mash objects containing only beat's 

chicrime.limit_query(2)
# => returns array of 2 Hashie:Mash objects

chicrime.order_query(:id)
# => returns array of Hashie::Mash objects in ascending order by id

chicrime.order_query(:id, :DESC)
# => returns array of Hashie::Mash objects in descending order by id

```

## Development

TODO: Method chaining

## Contributing

1. Fork it ( https://github.com/[my-github-username]/chicrime/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
