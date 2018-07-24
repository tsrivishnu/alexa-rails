module Alexa
  class Configuration
    attr_accessor :location_permission_type

    def initialize
      @location_permission_type = nil
    end
  end
end
