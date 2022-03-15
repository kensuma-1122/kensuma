FactoryBot.define do
  factory :business do
    uuid { SecureRandom.uuid }
    sequence(:name) { |n| "TEST企業#{n}" }
    name_kana { 'テストキギョウ' }
    branch_name { 'TEST支店' }
    representative_name { 'TEST代表' }
    sequence(:email) { |n| "test#{n}@example.com" }
    address { 'TEST' }
    post_code { '0120123' }
    phone_number { '09001230123' }
    carrier_up_id { '1' }
    business_type { 0 }
    user
  end
end
