# HPE Recovery Manger Central

This is a Ruby library for the HPE Recovery Manger Central (RMC).

## Installation

Add the Ruby RMC as dependency to your project Gemfile: 

```
source 'https://rubygems.org'
gem 'rmc'
```

## Usage

Create a connection and receive a API token.

```ruby
require 'rmc'

connection = RMC::Connection.new('https://rmc.domain.local', 'Admin', 'MySpecialPassword')

puts "Token is #{connection.token}"
```

## Maintainer

The library is currently maintained by [Nitrado](http://nitrado.net/).

## Authors

* Alexander Birkner (alexander.birkner@marbis.net)

## License

See LICENSE for license information.