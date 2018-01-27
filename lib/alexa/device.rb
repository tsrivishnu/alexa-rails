##
# This class represents the +device+ part in the request.
#
module Alexa
  class Device
    attr_accessor :attributes
    def initialize(attributes: {}, context:)
      @attributes = attributes
      @context = context
    end

    ##
    # Return device id
    def id
      attributes["deviceId"]
    end

    def audio_supported?
      attributes["supportedInterfaces"].keys.include?("AudioPlayer")
    end

    def video_supported?
      attributes["supportedInterfaces"].keys.include?("VideoApp")
    end

    ##
    # Return device location from amazon.
    # Makes an API to amazon alexa's device location service and returns the
    # location hash
    def location
      @_location ||= get_location
    end

    private

    def get_location
      url = "#{@context.api_endpoint}/v1/devices/#{id}/settings/address"
      conn = Faraday.new(url: url) do |conn|
        conn.options["open_timeout"] = 2
        conn.options["timeout"] = 3
        conn.adapter :net_http
        conn.headers["Authorization"] = "Bearer #{@context.api_access_token}"
      end
      begin
        resp = conn.get
        if resp.status == 200
          return JSON.parse(resp.body)
        end
      rescue Faraday::ConnectionFailed, JSON::ParserError => e
        Raven.capture_exception(
          e,
          extra: {
            deviceId: id,
            apiEndPoint: @context.api_endpoint
          }
        )
        return {}
      end
    end
  end
end
