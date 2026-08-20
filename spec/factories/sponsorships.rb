# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :sponsorship do
    sponsor
    sponsorship_level
    conference
  end
end
