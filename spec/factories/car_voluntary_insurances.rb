FactoryBot.define do
  factory :car_voluntary_insurance do
    personal_insurance { 1 }
    objective_insurance { 1 }
    car
    car_insurance_company
  end
end
