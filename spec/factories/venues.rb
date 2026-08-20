# Read about factories at https://github.com/thoughtbot/factory_bot
FactoryBot.define do
  factory :venue do
    conference
    name { "#{Faker::Company.name} Office" }
    street { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    postalcode { Faker::Address.postcode }
    country { Faker::Address.country_code }
    website { Faker::Internet.url }
    description { Faker::Lorem.sentence }
  end
end
