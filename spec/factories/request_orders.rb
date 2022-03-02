FactoryBot.define do
  factory :request_order do
    status { 0 }
    business
    order
  end
end
