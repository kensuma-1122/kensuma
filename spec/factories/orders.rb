FactoryBot.define do
  factory :order do
    status { 1 }
    site_uu_id { "MyString" }
    site_name { "MyString" }
    order_post_code { "MyString" }
    order_address { "MyString" }
  end
end
