require "alexa/engine"
require 'alexa/context'
require 'alexa/device'
require 'alexa/request'
require 'alexa/response'
require 'alexa/session'
require 'alexa/slot'
require 'alexa/version'
require 'alexa/configuration'
require 'alexa/responses/bye'
require 'alexa/responses/delegate'
require 'alexa/responses/permission_consents/device_address'
require 'alexa/intent_handlers/base'
require_relative '../app/models/alexa/user'
require_relative '../app/models/alexa/usage'

module Alexa
  # Manage configuration following the pattern from:
  # https://brandonhilkert.com/blog/ruby-gem-configuration-patterns/
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @_configuration ||= Alexa::Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
