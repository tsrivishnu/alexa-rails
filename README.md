# Alexa
`alexa-rails` is a ruby gem which is a mountable rails engine that will add abilities to your Ruby on Rails application to handle Amazon alexa requests and responses.

## Usage

### Request helpers

Include the helpers provided by the gem into the controller you want to handle alexa requests.

```ruby
class ApplicationController < ActionController::Base
  include Alexa::ContextHelper
end
```
Access the alexa requet object

```ruby
alexa_request # returns Alexa::Request object
```


## Installation
Add this line to your application's Gemfile:

```ruby
gem 'alexa'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install alexa
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
