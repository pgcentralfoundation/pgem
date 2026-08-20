# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :room_location do
    venue
    description { "#{Faker::Address.city} Building" }
  end
end
