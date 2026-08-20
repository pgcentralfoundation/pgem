# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :code do
    conference
    code_type
    sponsor
    sequence(:name) { |n| "CODE#{n}" }
    max_uses { 0 }
    discount { 0 }
  end
end
