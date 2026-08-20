# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :code_type do
    sequence(:title) { |n| "Code type #{n}" }
  end
end
