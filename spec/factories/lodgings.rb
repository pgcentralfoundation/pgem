# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :lodging do
    conference
    name { "#{Faker::App.name} Hotel" }
    description { Faker::Lorem.paragraph }
    website_link { Faker::Internet.url }
  end
end
