FactoryBot.define do
  factory :car do
    sequence(:owner_name) { |n| "車両所有者#{n}" }
    sequence(:safety_manager) { |n| "安全運転管理者#{n}" }
    sequence(:vehicle_model) { |n| "車両型式#{n}" }
    sequence(:vehicle_number) { |n| "車両番号#{n}" }
    vehicle_inspection_start_on { '2020-01-29' }
    vehicle_inspection_end_on { '2022-01-29' }
    sequence(:liability_securities_number) { |n| "自賠責証券番号#{n}" }
    liability_insurance_start_on { '2020-01-29' }
    liability_insurance_end_on { '2022-01-29' }
    sequence(:voluntary_securities_number) { |n| "任意保険証券番号#{n}" }
    voluntary_insurance_start_on { '2020-01-29' }
    voluntary_insurance_end_on { '2022-01-29' }
    images { '' }
    business
  end
end
