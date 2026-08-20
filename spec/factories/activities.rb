# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :activity do
    conference
    name { Faker::Lorem.sentence }
  end
end
