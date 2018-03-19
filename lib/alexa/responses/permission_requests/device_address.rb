module Alexa
  module Responses
    module PermissionRequests
      class DeviceAddress < Alexa::Response
        attr_accessor :intent, :directives

        def initialize(intent:, directives: [])
          @intent = intent
        end

        def partial_path(format: :ssml)
          if format == :ssml
            "alexa/#{intent.context.locale}/intent_handlers/"\
              "#{intent.class.name.demodulize.underscore}"\
              "/permission_requests/"\
              "device_address.ssml.erb"
          else
            "alexa/permission_requests/device_address.text.erb"
          end
        end

        def end_session?
          true
        end
      end
    end
  end
end
