module Alexa
  module Responses
    class Delegate
      def as_json(options={})
        {
          "version": "1.0",
          "response": {
            "directives": [
              {
                "type": "Dialog.Delegate"
              }
            ]
          }
        }
      end
    end
  end
end
