module Alexa
  module Responses
    class Delegate < Base
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
