FactoryBot.define do
  factory :ticket_purchase do
    user
    conference
    ticket
    code
    event
    payment
    quantity { 10 }
  end
end
