require 'spec_helper'

describe 'alexa-rails' do
  before do
    Alexa.configure do |config|
      config.location_permission_type = :country_and_postal_code
    end
  end
  it 'can set and read configuration' do
    expect(Alexa.configuration.location_permission_type).to eq(:country_and_postal_code)
  end
end
