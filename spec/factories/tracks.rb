FactoryBot.define do
  factory :track do
    name { Faker::Commerce.department(max: 2, fixed_amount: true) }
    description { Faker::Lorem.sentence }
    color { Faker::Color.hex_color }
    program
  end
end
