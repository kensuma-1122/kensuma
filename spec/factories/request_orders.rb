FactoryBot.define do
  factory :request_order do
    status { 0 }
    business_id { 1 }
    order
  end
end
