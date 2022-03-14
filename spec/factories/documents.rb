FactoryBot.define do
  factory :document do
    uuid { SecureRandom.uuid }
    document_type { 1 }
    created_on { '2022-03-08' }
    submitted_on { '2022-03-08' }
  end
end
