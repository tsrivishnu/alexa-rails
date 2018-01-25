module Alexa
  class Slot
    attr_accessor :name, :value

    def initialize(attributes={})
      @name = attributes['name']
      @value = attributes['value']
      @resolutions = attributes['resolutions']
    end

    def matched_value
      if matched?
        resolution["values"].first["value"]["name"]
      end
    end

    def matched_id
      if matched?
        resolution["values"].first["value"]["id"]
      end
    end

    def matched?
      return false if !has_resolutions?
      resolution["status"]["code"] == "ER_SUCCESS_MATCH"
    end

    def bad_match?
      return false if !has_resolutions?
      resolution["status"]["code"] == "ER_SUCCESS_NO_MATCH"
    end

    def has_resolutions?
      @resolutions.present?
    end

    def resolution
      return nil if !has_resolutions?
      @resolutions["resolutionsPerAuthority"].first
    end

    def as_json(options={})
      h = { name: name }
      # add other attributes only if they are present
      h.merge!(value: value) if value.present?
      h.merge!(resolutions: @resolutions) if @resolutions.present?
      h
    end
  end
end
