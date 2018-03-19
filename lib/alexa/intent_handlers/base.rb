module Alexa
  module IntentHandlers
    class Base
      class << self
        def inherited(subclass)
          subclass.instance_variable_set("@_required_slot_names", _required_slot_names.clone)
        end

        # Lets you set +required_slot_names+ per subclass
        #
        # class IntentHandlers::NewIntent < IntentHandlers::Base
        #   required_slot_names :Function, :CareerLevel
        # end
        #
        # handler = IntentHandlers::NewIntent.new
        # handler.required_slot_names   # => [:Function, :CareerLevel]

        def _required_slot_names
          @_required_slot_names ||= []
        end

        def required_slot_names(*names)
          @_required_slot_names = names.map(&:to_s)
        end
      end

      attr_accessor :context

      def initialize(alexa_context)
        @context = alexa_context
      end

      def request
        context.request
      end

      def handle
        raise "Override .handle"
      end

      def session
        request.session
      end

      def response
        @_response ||= Alexa::Response.new(intent: self)
      end

      def say_welcome?
        @say_welcome == true
      end

      def slots
        request.slots
      end

      def intent_usage_count
        @_usage_count ||= context.user.usage_count_for(intent_name: request.intent_name)
      end

      def show_device_address_permission_consent_card?
        @_show_device_address_permission_consent_card == true
      end


      protected

      def has_all_slots?
        empty_slots.empty?
      end

      def has_required_slots?
        non_empty_slot_names = non_empty_slots.map { |_, s| s.name }
        (required_slot_names - non_empty_slot_names).empty?
      end

      def empty_slots
        @_empty_slots ||= slots.select { |name, slot| slot.value.nil? }
      end

      def non_empty_slots
        @_non_empty_slots ||= slots.select { |name, slot| !slot.value.nil? }
      end

      def unmatched_slots
        @_unmatched_slots ||= slots.select { |_, slot| slot.bad_match? }
      end

      def required_slot_names
        self.class._required_slot_names
      end

      def intent_confirmed?
        # TODO: Move this to Alexa::Request
        request.params["request"]["intent"]["confirmationStatus"] == "CONFIRMED"
      end

      def intent_denied?
        # TODO: Move this to Alexa::Request
        request.params["request"]["intent"]["confirmationStatus"] == "DENIED"
      end

      def dialog_complete?
        dialog_state == "COMPLETED"
      end

      def has_unmatched_slots?
        unmatched_slots.any?
      end

      def dialog_state
        request.dialog_state
      end

      def sorry_response
        {
          "version": "1.0",
          sessionAttributes: session,
          "response": {
            "outputSpeech": {
              "type": "PlainText",
              "ssml": "Sorry! Looks like I couldn't process your request, may be try something else?"
            },
            "shouldEndSession": false
          }
        }
      end

      def show_device_address_permission_consent_card!
        @_show_device_address_permission_consent_card = true
      end

      def device_address_permission_consent_response
        @_device_address_permission_consent_response ||= Alexa::Responses::PermissionConsents::DeviceAddress.new(intent: self)
      end

      def delegate_response
        @_delegate_response ||= Alexa::Responses::Delegate.new
      end

      def bye_response
        @_bye_response ||= Alexa::Responses::Bye.new(intent: self)
      end

      def say_welcome!
        @say_welcome = true
      end

      def video_supported?
        context.device.video_supported?
      end

      def audio_supported?
        context.device.audio_supported?
      end
    end
  end
end
