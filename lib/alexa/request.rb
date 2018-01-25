module Alexa
  class Request
    attr_accessor :body, :params

    def initialize(request)
      @req = request
      @body = request.body
      @params = if request.body.size > 0
                  request.body.rewind
                  JSON.parse(request.body.read).with_indifferent_access
                else
                  {}
                 end
    end

    def application_id
      session.application_id
    end

    def user_id
      session.user_id
    end

    def type
      params["request"]["type"]
    end

    def intent_request?
      type == "IntentRequest"
    end

    def launch_request?
      type == "LaunchRequest"
    end

    def session_ended_request?
      type == "SessionEndedRequest"
    end

    def help_request?
      intent_request? && intent_name == "AMAZON.HelpIntent"
    end

    def cancel_request?
      intent_request? && intent_name == "AMAZON.CancelIntent"
    end

    def session
      @_session ||= Alexa::Session.new(params["session"].dup)
    end

    def slots
      @_slots ||= begin
                    if intent_request?
                      return [] if help_request?
                      return [] if cancel_request?

                      params["request"]["intent"]["slots"]
                        .inject(HashWithIndifferentAccess.new) do |hash, slot|
                        name = slot[0]
                        data = slot[1]
                        hash[name] = Alexa::Slot.new(data)
                        hash
                      end
                    else
                      []
                    end
                  end
    end

    def dialog_state
      params["request"]["dialogState"]
    end

    def valid?
      Rails.configuration.x.alexa.skill_ids.include?(application_id)
    end

    def intent_name
      return nil if !intent_request?
      params["request"]["intent"]["name"]
    end

    def locale
      request_locale = params["request"]["locale"]
      case params["request"]["locale"]
      when "en-US", "en-GB", "en-IN", 'en-CA'
        # this is to match pjpp locale codes
        params["request"]["locale"].gsub("-", "_").downcase
      when "de-DE"
        "de"
      else
        "en_gb"
      end
    end
  end
end
