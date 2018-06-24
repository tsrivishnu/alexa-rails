module Alexa
  module Responses
    module PermissionConsents
      class DeviceAddress < Alexa::Response
        attr_accessor :intent, :directives

        def initialize(intent:, directives: [])
          @intent = intent
        end

        def partial_path(format: :ssml)
          if format == :ssml
            "alexa/#{intent.context.locale.downcase}/intent_handlers/"\
              "#{intent.class.name.demodulize.underscore}"\
              "/permission_consents/"\
              "device_address.ssml.erb"
          else
            "alexa/permission_consents/device_address.text.erb"
          end
        end

        def end_session?
          true
        end
      end
    end
  end
end
