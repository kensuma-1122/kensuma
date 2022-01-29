FactoryBot.define do
  factory :car do
    owner_name { "MyString" }
    safety_manager { "MyString" }
    vehicle_model { "MyString" }
    vehicle_number { "MyString" }
    vehicle_inspection_start_on { "2022-01-29" }
    vehicle_inspection_end_on { "2022-01-29" }
    liability_securities_number { "MyString" }
    liability_insurance_start_on { "2022-01-29" }
    liability_insurance_end_on { "2022-01-29" }
    voluntary_securities_number { "MyString" }
    voluntary_insurance_start_on { "2022-01-29" }
    voluntary_insurance_end_on { "2022-01-29" }
    images { "" }
  end
end
