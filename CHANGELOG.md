## Version 0.1.4
* Add:
  * `Alexa::Request#language_code` and `Alexa::Request#country_code`.

## Version 0.1.3
* Fixes:
  * Issue: #6: `Alexa::Request#locale` was modifying the locale string instead
  of returning the string from request as is.
  This has now been fixed in 18f3c38.

## Version 0.1.2
* Add configuration option to set default card title

Change rails dependancy to `>= 5.0`
