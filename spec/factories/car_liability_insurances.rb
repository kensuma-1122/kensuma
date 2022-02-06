FactoryBot.define do
  factory :car_liability_insurance do
    association :car_insurance_company, factory: :car_insurance_company
    association :car, factory: :car
  end
end
