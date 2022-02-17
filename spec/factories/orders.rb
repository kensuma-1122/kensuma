FactoryBot.define do
  factory :order do
    association :business
    status { rand(2) }
    sequence(:site_name) { |n| "site_name#{n}" }
    sequence(:order_name) { |n| "order_name#{n}" }
    order_post_code { '%.7d' % rand(10000000) }
    sequence(:order_address) { '東京都テスト区テスト1-2-3' }
  end
end
