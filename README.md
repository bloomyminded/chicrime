# Chicrime
[![Coverage Status](https://coveralls.io/repos/bloomyminded/chicrime/badge.svg?branch=master&service=github)](https://coveralls.io/github/bloomyminded/chicrime?branch=master) [![Build Status](https://travis-ci.org/bloomyminded/chicrime.png?branch=master)](https://travis-ci.org/bloomyminded/chicrime) [![Gem Version](https://badge.fury.io/rb/chicrime.svg)](http://badge.fury.io/rb/chicrime)

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

# Add queries with where, select, query, and order

# where
chicrime.where("year = '2014'")

# select
chicrime.select('date', 'arrest', 'location')

# limit
chicrime.limit(5)

# order
chicrime.order("id", :DESC)

# Chain queries
chicrime.where("year = '2014'", "community_area = '1'").limit(100)
chicrime.where("within_circle(location, 41.8719708, -87.6492965, 500)").order("date")

# Get results
chicrime.where("year = '2014'", "community_area = '1'").order("date").results
```

## Resources

[API Documentation](http://dev.socrata.com/foundry/#/data.cityofchicago.org/ijzp-q8t2)

[SoQL Queries](http://dev.socrata.com/docs/queries.html)

[Location functions](http://dev.socrata.com/docs/datatypes/location.html)

## Development

TODO
 - Implement group query
 - Documentation
 - Hash support for method queries

## Contributing

1. Fork it ( https://github.com/[my-github-username]/chicrime/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
