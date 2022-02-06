FactoryBot.define do
  factory :car_insurance_company do
    sequence(:name) { |n| "company#{n}" }
  end
end
