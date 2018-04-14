module Alexa
  module Responses
    class Base
      def as_json(options={})
        raise "Override #as_json"
      end
    end
  end
end
