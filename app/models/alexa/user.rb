module Alexa
  class User < ApplicationRecord
    self.table_name = 'alexa_users'
    belongs_to :account
    has_many :usages, class_name: "Alexa::Usage", foreign_key: "alexa_user_id"

    def update_usage(intent_name:)
      usage = usages.where(intent_name: intent_name).first_or_initialize
      usage.increment_count!
    end

    def usage_count_for(intent_name:)
      usage = usages.where(intent_name: intent_name).first
      return 0 if usage.nil?
      usage.count
    end
  end
end
