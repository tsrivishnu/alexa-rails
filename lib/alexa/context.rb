module Alexa
  class Context
    attr_accessor :request

    def initialize(alexa_request)
      @request = alexa_request
    end

    def user
      @_user ||= Alexa::User.where(
        amazon_id: request.user_id
      ).first_or_create
    end

    def session
      request.session
    end

    def locale
      request.locale
    end

    ##
    # Returns country code from locale. Always in lowercase
    ##
    def country_code
      return nil if locale.nil?
      @_country_code ||= locale.split("-").last.downcase
    end

    ##
    # Returns language code from locale. Always in lowercase
    ##
    def language_code
      return nil if locale.nil?
      @_language_code ||= locale.split("-").first.downcase
    end

    def device
      @_device ||= Alexa::Device.new(
        attributes: request.params["context"]["System"]["device"],
        context: self
      )
    end

    def api_endpoint
      request.params["context"]["System"]["apiEndpoint"]
    end

    def api_access_token
      request.params["context"]["System"]["apiAccessToken"]
    end
  end
end
