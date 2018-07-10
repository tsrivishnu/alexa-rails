## Version 0.1.7
* Add:
  * `Alexa::Response#partial_path` to override only a path to the templates
  in a response.
## Version 0.1.6

* Remove:
  * `Alexa::IntentHandler::Base#show_device_address_permission_consent_card!`
  and `Alexa::IntentHandler::Base#show_device_address_permission_consent_card?`
    - default repsonses will no longer render device address permission cards.

* Add:
  * Abilty to render a custom template in a response with
  `Alexa::Response#with(template: )`. See:
  https://github.com/tsrivishnu/alexa-rails/issues/9

* Changes:
  * Default intent handler view files are no more `speech.ssml.erb` and
  `display.text.erb`. They are now renamed to `default.ssml.erb` and
  `default.text.erb`. See:
  https://github.com/tsrivishnu/alexa-rails/issues/10

## Version 0.1.5
* Remove:
  * `Alexa::Request#language_code` and `Alexa::Request#country_code`.
    - Move them to `Alexa::Context`.

* Add:
  * `Alexa::Context#language_code` and `Alexa::Context#country_code`.

## Version 0.1.4
* Add:
  * `Alexa::Request#language_code` and `Alexa::Request#country_code`.

## Version 0.1.3
* Fixes:
  * Issue: https://github.com/tsrivishnu/alexa-rails/issues/6: `Alexa::Request#locale` was modifying the locale string instead
  of returning the string from request as is.
  This has now been fixed in https://github.com/tsrivishnu/alexa-rails/commit/18f3c3878b9923a8df229bef34b1d2a9319c0dc0.

## Version 0.1.2
* Add configuration option to set default card title

Change rails dependancy to `>= 5.0`
