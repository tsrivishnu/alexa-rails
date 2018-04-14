# Provides easy access to session data from the request.
#
# Extends from +HashWithIndifferentAccess+ and initailised with the
# session hash from the request
#
# <b>Session variables</b>:
# Session variables can be accessed the same way as accessing hash with keys.
# ```ruby
# session[:my_var] # Reads the variable
# session.merge!(my_var: "Some value") # Write a session variable
# ```
#
# Apart from session handling, class also provides an API to other session
# related information.
module Alexa
  class Session < HashWithIndifferentAccess
    def initialize(session={})
      @variables = session
      super(session["attributes"])
    end

    # Get the elicitation count of a slot.
    #
    # Elicitation counts are maintained in the session so that they
    # can be referred to within the intenthandlers or the views
    #
    # Options:
    #   - slot_name: Slot name to return the elicitation count for
    def elicitation_count_for(slot_name)
      self["elicitations"] ||= {}
      if self["elicitations"][slot_name].present?
        return self["elicitations"][slot_name]["count"] end
      return 0
    end

    # Increase the elicitation count of a slot.
    #
    # Elicitation counts are maintained in the session so that they
    # can be referred to within the intenthandlers or the views
    #
    # Options:
    #   - slot_name: Slot name to increment the elicitation count for
    def increment_elicitation_count!(slot_name)
      count = elicitation_count_for(slot_name)
      self["elicitations"].merge!(
        "#{slot_name}": { count: count + 1 }
      )
    end

    # Whether its a new session.
    def new?
      @variables["new"] == true
    end

    # Get application's ID from session
    def application_id
      @variables["application"]["applicationId"]
    end

    # Get Amazon user's ID from session
    def user_id
      @variables["user"]["userId"]
    end
  end
end
