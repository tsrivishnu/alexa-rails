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

### Views

We follow convention to write views for intent responses.
Also, the views are context locale dependant.

Given an intent named `PlaceOrder`, you view files would be

  * SSML: `views/alexa/en_us/intent_handlers/place_order/speech.ssml.erb`
  * Card: `views/alexa/en_us/intent_handlers/place_order/display.txt.erb`

In case of slot elicitations, follow a similar convention but make sure you
name the `ssml` and `txt` files with the same name as the slot that is being
elicited. For example, in the `PlaceOrder` intent, the elicatation for `Address`
slot would have the following views

  * SSML: `views/alexa/en_us/intent_handlers/place_order/elicitations/address.ssml.erb`
  * Card: `views/alexa/en_us/intent_handlers/place_order/elicitations/address.txt.erb`

#### SSML

##### Re-prompts

By default, there is no re-prompt SSML is added to the response.
However, re-prompt SSML can be set in the ssml view of the intent response or
a slot elicitation view with a `content_for :repromt_ssml` like this:

```erb
What is your address?

<% content_for :repromt_ssml do %>
  Where would you like the pizza to be delivered?
<% end %>
```

#### Cards

##### Type & Title

By default, the card type is set to `Simple`.
To change the card type and title, use the `content_for` blocks in the `txt`
view file for the response as follows:

```erb
<% content_for :card_type do %>
  Simple
<% end %>
<% content_for :card_title do %>
  Get your pizza
<% end %>

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
