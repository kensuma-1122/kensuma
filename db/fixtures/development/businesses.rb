User.first(10).each do |user|
  Business.seed(:id,
    {
      id:                  user.id,
      user_id:             user.id,
      uuid:                SecureRandom.uuid,
      name:                "テスト建設#{user.id}",
      name_kana:           "テストケンセツイチ#{user.id}",
      branch_name:         "テスト支店#{user.id}",
      representative_name: "代表#{user.name}",
      email:               "sample_#{user.id}@email.com",
      address:             "サンプル住所#{user.id}丁目",
      post_code:           '1234567',
      phone_number:        '0312345678',
      carrier_up_id:       'abcde12345',
      business_type:       0
    }
  )
end
