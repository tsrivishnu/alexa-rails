module Alexa
  class Usage < ActiveRecord::Base
    self.table_name = 'alexa_usages'
    belongs_to :alexa_user

    def increment_count!
      self.count = self.count + 1
      save!
    end
  end
end
