FactoryBot.define do
  factory :news do
    title { 'TEST1_TITLE' }
    content { 'TEST1_CONTENT' }
    delivered_at { '2022-02-15 07:59:49' }
    uuid { '12345678-11aa-22bb-33cc-1234567890ab' }
    status { 0 }
  end
end
