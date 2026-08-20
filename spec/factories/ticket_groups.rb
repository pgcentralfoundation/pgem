# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :ticket_group do
    conference
    name { Faker::Commerce.department }
  end
end
