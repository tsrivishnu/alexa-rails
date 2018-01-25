module Alexa
  module ContextHelper
    def alexa_response
      @_alexa_response
    end

    def alexa_response=(resp)
      @_alexa_response = resp
    end

    def context_alexa_user
      alexa_context.user
    end

    def alexa_context
      @_alexa_context ||= Alexa::Context.new(alexa_request)
    end

    def alexa_request
      @_alexa_request ||= Alexa::Request.new(request)
    end
  end
end
