FactoryBot.define do
  factory :car_voluntary_insurance do
    personal_insurance { 2 }
    objective_insurance { 3 }
    sequence(:voluntary_securities_number) { |n| "67890#{n}" }
    voluntary_insurance_start_on { '2022-01-30' }
    voluntary_insurance_end_on { '2022-01-30' }
  end
end
