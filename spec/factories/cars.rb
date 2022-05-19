FactoryBot.define do
  factory :car do
    sequence(:owner_name) { |n| "owner#{n}" }
    sequence(:safety_manager) { |n| "manager#{n}" }
    sequence(:vehicle_model) { |n| "model#{n}" }
    sequence(:vehicle_number) { |n| "12-3#{n}" }
    vehicle_inspection_start_on { '2022-01-30' }
    vehicle_inspection_end_on { '2022-01-30' }
    sequence(:liability_securities_number) { |n| "12345#{n}" }
    liability_insurance_start_on { '2022-01-30' }
    liability_insurance_end_on { '2022-01-30' }
    uuid { '12345678-11aa-22bb-33cc-1234567890ab' }
    business
    car_insurance_company
  end
end
