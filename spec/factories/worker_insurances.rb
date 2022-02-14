FactoryBot.define do
  factory :worker_insurance do
    association :worker
    health_insurance_type { 1 }
    health_insurance_name { 'MyString' }
    pension_insurance_type { 1 }
    employment_insurance_type { 1 }
    employment_insurance_number { '1234' }
    severance_pay_mutual_aid_type { 1 }
    severance_pay_mutual_aid_name { 'MyString' }
  end
end
