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

    def geocode
      return nil if !location.present?
      @_geocode ||= get_geocode
    end

    private

    def get_geocode
      countries = Country.where(
        "lower(code) = ?", location["countryCode"].downcase
      ).order("country_version_id ASC")
      # order is to ensure we prefer our main countries.
      # for example, DE return Germany first and Delaware later
      matched_geocode = nil

      # try finding in the databaes directly
      countries.each do |country|
        atched_geocode = Geocode.find_by_zip_or_city(
          country.id,
          location["postalCode"],
          location["city"]
        )
        break if matched_geocode.present?
      end

      # if its still +nil+, try JCA
      if matched_geocode.nil?
        begin
          client = Alexa::JcaClient.instance
          locale = if @context.locale =~ /en_*/
                     'en'
                   else
                     @context.locale
                   end
          geocodes = client.locations.all(
            language: locale,
            keyword: location["city"],
            location_state_name: location["stateOrRegion"],
            country_id: countries.first.try(:id)
          )

          if geocodes.present?
            matched_geocode = Geocode.find(geocodes.first[:id])
          end
        rescue Exception => e
          # Ideally, we should't catch all exceptions but this isn't a very
          # crucial part of the skill when we can't tell the device's location.
          # We don't want to break the user experience.
          Raven.capture_exception(
            e,
            extra: {
              device_location: @context.device.location
            }
          )
        end
      end

      matched_geocode
    end

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
