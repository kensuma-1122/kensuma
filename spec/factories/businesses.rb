FactoryBot.define do
  factory :business do
    association :user

    uuid { SecureRandom.uuid }
    sequence(:name)  { |n| "TEST企業#{n}" }
    sequence(:name_kana) { |n| "テストキギョウ#{n}" }
    sequence(:branch_name) { |n| "TEST支店#{n}" }
    sequence(:representative_name) { |n| "TEST代表#{n}" }
    sequence(:email) { |n| "test#{n}@example.com" }
    address { "TEST" }
    post_code { "012-0123" }
    phone_number { "090-0123-0123" }
    carrier_up_id { "0001" }
    business_type { 0 }
  end
end
