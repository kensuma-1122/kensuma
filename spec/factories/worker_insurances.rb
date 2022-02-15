FactoryBot.define do
  factory :worker_insurance do
    health_insurance_type { 'health_insurance_association' }
    health_insurance_name { 'insurance_name' }
    pension_insurance_type { 'welfare' }
    employment_insurance_type { 'insured' }
    employment_insurance_number { '1234' }
    severance_pay_mutual_aid_type { 'kentaikyo' }
    severance_pay_mutual_aid_name { 'aid_name' }
    association :worker

    # enumをまとめて定義(enumの各値が使える)
    WorkerInsurance.health_insurance_types.each_value do |type|
      trait(:"#{type}") { health_insurance_type { type } }
    end

    WorkerInsurance.pension_insurance_types.each_value do |type|
      trait(:"#{type}") { pension_insurance_type { type } }
    end

    WorkerInsurance.employment_insurance_types.each_value do |type|
      trait(:"#{type}") { employment_insurance_type { type } }
    end

    WorkerInsurance.severance_pay_mutual_aid_types.each_value do |type|
      trait(:"#{type}") { severance_pay_mutual_aid_type { type } }
    end
  end
end
