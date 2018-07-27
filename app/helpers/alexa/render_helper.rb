module Alexa
  module RenderHelper
    def respond_for_alexa_with(alexa_response)
      if alexa_response.nil?
        render :not_found
      else
        render partial: 'alexa/response.json', locals: { response: alexa_response }
      end
    end

    private

    def render(*args)
      options = args.extract_options!
      options[:template] = "/app/views/"
      super(*(args << options))
    end
  end
end
