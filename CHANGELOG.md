## Version 0.1.6
* Remove:
  * `Alexa::IntentHandler::Base#show_device_address_permission_consent_card!`
  and `Alexa::IntentHandler::Base#show_device_address_permission_consent_card?`
    - default repsonses will no longer render device address permission cards.
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
