module Alexa
  module Responses
    class Bye < Alexa::Response
      attr_accessor :intent, :directives

      def initialize(intent:, directives: [])
        @intent = intent
      end

      def partial_path(format: :ssml)
        template_path = "alexa/#{intent.context.locale.downcase}/intent_handlers/"\
          "#{intent.class.name.demodulize.underscore}"

        if format == :ssml
          "#{template_path}/bye.ssml.erb"
        else
          "#{template_path}/bye.text.erb"
        end
      end

      def end_session?
        true
      end
    end
  end
end
