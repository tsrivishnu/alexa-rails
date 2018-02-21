# Alexa
`alexa-rails` is a ruby gem which is a mountable rails engine that will add abilities to your Ruby on Rails application to handle Amazon alexa requests and responses.

## Intallation/Usage

Do the usual by adding the following to your Gemfile:

```ruby
gem install alexa-rails
```

### Migrations

The gem provides migrations that are needed to use few features of the gem.
For example: Saving or reading the user's skill usage count.
To generate the migrations, run the following

```ruby
$ rails generate alexa:migrations
$ rake db:migrate
```

### Configuration

Set alexa skill IDs in environment config (ex: config/environments/development.rb).


```ruby
  # config/environments/development.rb

  config.x.alexa.skill_ids = [
    "amzn1.ask.skill.xxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxx"
  ]
```

Mount the engine for routes handling in your routes

```ruby
  # config/routes.rb

  Rails.application.routes.draw do
    ...
    mount Alexa::Engine, at: "/alexa"
  end
```

### Request handling

After the above steps, your application is ready to accept requests from Alexa
servers at `/alexa/intent_handlers`.
You will have to provide that in the HTTPS endpoint URL for your skill.

To handle an intent, you will have to create an intent handler class.
For example, if your intent is named `PlaceOrder`, you will have to create
the following file under you `app/lib/intent_handlers` directory.

```ruby
module Alexa
  module IntentHandlers
    class PlaceOrder < Alexa::IntentHandlers::Base
      def handle
        ...
      end
    end
  end
end
```

All intent handlers should contain a `#handle` method that has required logic
as to how to handle the intent request. For example, adding session variables,
setting response to elicit slots, etc.

Adding session variable:

```ruby
session.merge!(my_var: value)
```

#### Slot elicitations

Depending on your conditions, you can set the reponse to elicit a specific
slot and the respecitve views are used.

```ruby
response.elicit_slot!(:SlotName)
```

### Views

The content for speech and display cards is not set in the intent handler
classes.
We follow rails convention and expect all response content for intents to be
in their respective view files.

Also, the views are context locale dependant.

Given an intent named `PlaceOrder`, you view files would be

  * SSML: `views/alexa/en_us/intent_handlers/place_order/speech.ssml.erb`
  * Card: `views/alexa/en_us/intent_handlers/place_order/display.text.erb`

In case of slot elicitations, follow a similar convention but make sure you
name the `ssml` and `text` files with the same name as the slot that is being
elicited. For example, in the `PlaceOrder` intent, the elicatation for `Address`
slot would have the following views

  * SSML: `views/alexa/en_us/intent_handlers/place_order/elicitations/address.ssml.erb`
  * Card: `views/alexa/en_us/intent_handlers/place_order/elicitations/address.text.erb`

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
To change the card type and title, use the `content_for` blocks in the `text`
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
