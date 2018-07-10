module Alexa
  module Responses
    class Bye < Alexa::Response
      attr_accessor :intent, :directives

      def initialize(intent:, directives: [])
        @intent = intent
      end

      def partial_path(format: :ssml)
        if format == :ssml
          "#{partials_directory}/bye.ssml.erb"
        else
          "#{partials_directory}/bye.text.erb"
        end
      end

      def partials_directory
        @_partials_directory ||= "alexa/#{intent.context.locale.downcase}/intent_handlers/"\
          "#{intent.class.name.demodulize.underscore}"
      end

      def end_session?
        true
      end
    end
  end
end
