FactoryBot.define do
  factory :car_voluntary_insurance do
    personal_insurance { 0 }
    objective_insurance { 0 }
    association :car_insurance_company
    association :car
  end
end