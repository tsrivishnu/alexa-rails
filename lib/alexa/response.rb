module Alexa
  class Response
    attr_accessor :intent, :directives

    def initialize(intent:, directives: [])
      @intent = intent
      @directives = directives
      @slots_to_not_render_elicitation = []
    end

    # Marks a slot for elicitation.
    #
    # Options:
    #  - skip_render: Lets you skip the rendering of the elicited slot's view.
    #                 Helpful when you have the elication text already in the
    #                 response and don't wanna override it.
    def elicit_slot!(slot_to_elicit, skip_render: false)
      directives << {
        type: "Dialog.ElicitSlot",
        slotToElicit: slot_to_elicit
      }

      if skip_render
        @slots_to_not_render_elicitation << slot_to_elicit
      end
    end

    def partial_path(format: :ssml, filename: nil)
      if elicit_directives.any?
        slot_to_elicit = elicit_directives.first[:slotToElicit]
      end

      template_path = "alexa/#{intent.context.locale}/intent_handlers/"\
        "#{intent.class.name.demodulize.underscore}"

      if filename.present?
        if format == :ssml
          "#{template_path}/#{filename}.ssml.erb"
        else
          "#{template_path}/#{filename}.text.erb"
        end
      else
        if slot_to_elicit.present? && !@slots_to_not_render_elicitation.include?(slot_to_elicit)
          if format == :ssml
            "#{template_path}/elicitations/#{slot_to_elicit.underscore}.ssml.erb"
          else
            "#{template_path}/elicitations/#{slot_to_elicit.underscore}.text.erb"
          end
        else
          if format == :ssml
            "#{template_path}/default.ssml.erb"
          else
            "#{template_path}/default.text.erb"
          end
        end
      end
    end

    def elicit_directives
      return [] if directives.empty?
      directives.select { |directive| directive[:type] == "Dialog.ElicitSlot" }
    end

    def keep_listening!
      @keep_listening = true
      self
    end

    def keep_listening?
      @keep_listening == true
    end

    def end_session?
      return false if keep_listening?
      return false if elicit_directives.any?
      return true
    end
  end
end
