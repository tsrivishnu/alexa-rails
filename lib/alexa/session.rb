module Alexa
  class Session < HashWithIndifferentAccess
    def initialize(session={})
      @variables = session
      super(session["attributes"])
    end

    def elicitation_count_for(slot_name)
      self["elicitations"] ||= {}
      if self["elicitations"][slot_name].present?
        return self["elicitations"][slot_name]["count"]
      end
      return 0
    end

    def increment_elicitation_count!(slot_name)
      count = elicitation_count_for(slot_name)
      self["elicitations"].merge!(
        "#{slot_name}": { count: count + 1 }
      )
    end

    def new?
      @variables["new"] == true
    end

    def application_id
      @variables["application"]["applicationId"]
    end

    def user_id
      @variables["user"]["userId"]
    end
  end
end
