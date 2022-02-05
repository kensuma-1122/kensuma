FactoryBot.define do
  factory :car_insurance_company do
    sequence(:name) { |n| "company#{n}" }
    after(:create) do |car_insurance_company|
      create_list(:car_liability_insurance, 1, car_insurance_company: car_insurance_company, car: create(:car))
    end
  end
end
