FactoryBot.define do
  factory :news do
    title { 'TEST1_TITLE' }
    content { 'TEST1_CONTENT' }
    delivered_at { '2022-02-15 07:59:49' }
    status { 0 }
  end
end
