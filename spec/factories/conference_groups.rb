# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :conference_group do
    sequence(:name) { |n| "#{Faker::Company.name} #{n}" }
  end
end
