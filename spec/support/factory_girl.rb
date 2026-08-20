require_relative 'external_request'

RSpec.configure do |config|

  config.before(:suite) do
    if ENV['OSEM_FACTORY_LINT'] != 'false'
      mock_commercial_request
      # :commercial is an intentional abstract base (matches upstream OSEM) -
      # only its conference_commercial/event_commercial subtypes, which set
      # commercialable, are ever built directly.
      FactoryBot.lint(FactoryBot.factories.reject { |f| f.name == :commercial })
    end
  end

end
