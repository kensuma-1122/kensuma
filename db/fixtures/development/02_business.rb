User.all.each do |user|
  Business.seed(:id,
    {
      id:                  user.id,
      user_id:             user.id,
      name:                "テスト建設#{user.id}",
      name_kana:           "テストケンセツ#{user.id}",
      branch_name:         "テスト支店#{user.id}",
      representative_name: user.name,
      email:               "test_kensetu#{user.id}@email.com",
      address:             "東京都テスト区1-2-#{user.id}",
      post_code:           '0123456',
      phone_number:        '01234567898',
      carrier_up_id:       'abc123',
      business_type:       0
    }
  )
end
