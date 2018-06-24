# Alexa-rails
`alexa-rails` is a ruby gem which is a mountable rails engine that will add abilities to your Ruby on Rails application to handle Amazon alexa requests and responses.

## Intallation/Usage

Do the usual by adding the following to your `Gemfile`:

```ruby
gem 'alexa-rails'
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

  # For request validation
  config.x.alexa.skill_ids = [
    "amzn1.ask.skill.xxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxx"
  ]

  config.x.alexa.default_card_title = "Alexa rails"
```

Mount the engine for routes handling in your routes

```ruby
  # config/routes.rb

  Rails.application.routes.draw do
    ...
    mount Alexa::Engine, at: "/alexa"
  end
```

This will make you Rails app accept `POST` requests from Alexa at
```
https://<your-domain>/alexa/intent_handlers
```
This has to be provided as the HTTPS endpoint URL for the skill.

### Request handling

To handle an intent, you will have to create an intent handler class.
For example, if your intent is named `PlaceOrder`, you will have to create
the following file under you `app/lib/alexa/intent_handlers` directory.

```ruby
module Alexa
  module IntentHandlers
    class PlaceOrder < Alexa::IntentHandlers::Base
      def handle
        ...
        response # intent handlers should always return the +response+ object
      end
    end
  end
end
```

All intent handlers should contain a `#handle` method that has required logic
as to how to handle the intent request. For example, adding session variables,
setting response to elicit slots, delegate etc.

**Note**: `#handle` method should always return the `response` object.
`response` object in available in the scope of `#handle`.

See [Handling Amazon's Built-in Intents / Other request types] section to see
how to handle Amazon's built-in intent and other requests types.

#### Adding session variable:

```ruby
session.merge!(my_var: value)

# Accesssing session variable
session[:my_var]
```

#### Slot elicitations

Depending on your conditions, you can set the reponse to elicit a specific
slot and the respecitve views are used.

```ruby
response.elicit_slot!(:SlotName)
```

#### Delegate response

`#handle` is expected to return an instance of `Alexa::Response` or its subclasses.
In normal cases, the `response` object is returned.
In cases where the slots elicitation is delegated to alexa, an instance of
`Alexa::Responses::Delegate` has to be returned.

```ruby
  def handle
    ...
    return Alexa::Responses::Delegate.new
  end
```

### Views

The content for SSML and display cards is not set in the intent handler
classes.
We follow rails convention and expect all response content for intents to be
in their respective `default` view files.

Also, the views are context locale dependant.

Given an intent named `PlaceOrder`, you view files would be

  * SSML: `views/alexa/en_us/intent_handlers/place_order/default.ssml.erb`
  * Card: `views/alexa/en_us/intent_handlers/place_order/default.text.erb`

In case of slot elicitations, follow a similar convention but make sure you
name the `ssml` and `text` files with the same name as the slot that is being
elicited. For example, in the `PlaceOrder` intent, the elicatation for `Address`
slot would have the following views

  * SSML: `views/alexa/en_us/intent_handlers/place_order/elicitations/address.ssml.erb`
  * Card: `views/alexa/en_us/intent_handlers/place_order/elicitations/address.text.erb`

##### Render custom template instead of default

If you wish to force the `response` object to take contents from a different
template file instead of `default.*.erb`, pass the custom filename with
`Alexa::Response#with(template: )`.

For example: Instead of `default`, if you wish to render the contents of
`no_results.ssml.erb` and `no_results.text.erb`, return the response by forcing
the template with the following:

```ruby
  def handle
    ...
    return response.with(template: :no_results)
  end
```
and make sure you add your contents in the `no_results.*.erb` files in your
intent handlers' views' directory.

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

##### Permission cards

To render a permission card. Use `ask_for_permissions_consent` as the `card_type`
and provide the scope in `permissions_scope` content_for block.
Following is an example for Device address permission card.

```erb
<% content_for :card_type do %>
  ask_for_permissions_consent
<% end %>

<% content_for :permissions_scope do %>
  read::alexa:device:all:address
<% end %>
```

*Note*: The permission card should not have any other content other than the
content for `card_type` and `permissions_scope`.

## Handling Amazon's Built-in Intents / Other request types

Requests for Amazon's built-in intents and other request types
are also handled with intent handlers.
Below is the mapping for every request type and respective
intent handler classes.
These intent handlers are not included in the gem as they are a
but specific to the application.
Refer to the table below and implement the intent handlers.

Built-in Intents:

| Intent name | Handler class |
| ------------- | ------------- |
| AMAZON.CancelIntent | `Alexa::IntentHandlers::GoodBye` |
| AMAZON.StopIntent | `Alexa::IntentHandlers::GoodBye` |
| AMAZON.HelpIntent | `Alexa::IntentHandlers::Help` |

Other request types:

| Request type | Handler class |
| ------------- | ------------- |
| Launch request | `Alexa::IntentHandlers::LaunchApp` |
| Session end request | `Alexa::IntentHandlers::SessionEnd` |

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
