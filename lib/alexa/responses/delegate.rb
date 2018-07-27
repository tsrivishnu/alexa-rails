module Alexa
  module Responses
    class Delegate < Alexa::Response
      def initialize(intent:)
        @intent = intent
        @directives = [
          {
            "type": "Dialog.Delegate"
          }
        ]
      end

      def partial_path(format: :ssml, filename: nil)
        return nil
      end

      def end_session?
        return false
      end
    end
  end
end
