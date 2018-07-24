module Alexa
  class Configuration
    attr_accessor :location_permission_type, :default_card_title, :skill_ids

    def initialize
      @location_permission_type = nil
      @default_card_title = 'Card title'
      @skill_ids = []
    end
  end
end
