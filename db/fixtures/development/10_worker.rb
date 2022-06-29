3.times do |n|
  Worker.seed(:id,
    {
      id: n+1,
      business_id:         1,
      uuid:                 SecureRandom.uuid,
      name:                "テスト作業員#{n+1}",
      name_kana:           "テストサギョウイン#{n+1}",
      country:             "日本",
      my_address:          "東京都サギョウ区1-2-#{n+1}",
      my_phone_number:     '01234567898',
      family_address:      "千葉県サギョウ区1-2-#{n+1}",
      family_phone_number: '01234567898',
      birth_day_on:        '2000-01-01',
      abo_blood_type:      0,
      rh_blood_type:       0,
      job_title:            '主任',
      hiring_on:           '2022-01-01',
      experience_term_before_hiring: 1,
      blank_term:          1
    }
  )
end

3.times do |n|
  Worker.seed(:id,
    {
      id: n+4,
      business_id:         2,
      uuid:                 SecureRandom.uuid,
      name:                "テスト作業員#{n+4}",
      name_kana:           "テストサギョウイン#{n+4}",
      country:             "日本",
      my_address:          "東京都サギョウ区1-2-#{n+4}",
      my_phone_number:     '01234567898',
      family_address:      "千葉県サギョウ区1-2-#{n+4}",
      family_phone_number: '01234567898',
      birth_day_on:        '2000-01-01',
      abo_blood_type:      0,
      rh_blood_type:       0,
      job_title:            '係員',
      hiring_on:           '2022-01-01',
      experience_term_before_hiring: 1,
      blank_term:          1
    }
  )
end

3.times do |n|
  Worker.seed(:id,
    {
      id: n+7,
      business_id:         3,
      uuid:                 SecureRandom.uuid,
      name:                "テスト作業員#{n+7}",
      name_kana:           "テストサギョウイン#{n+7}",
      country:             "日本",
      my_address:          "東京都サギョウ区1-2-#{n+7}",
      my_phone_number:     '01234567898',
      family_address:      "千葉県サギョウ区1-2-#{n+7}",
      family_phone_number: '01234567898',
      birth_day_on:        '2000-01-01',
      abo_blood_type:      0,
      rh_blood_type:       0,
      job_title:            '係員',
      hiring_on:           '2022-01-01',
      experience_term_before_hiring: 1,
      blank_term:          1
    }
  )
end

3.times do |n|
  Worker.seed(:id,
    {
      id: n+10,
      business_id:         4,
      uuid:                 SecureRandom.uuid,
      name:                "テスト作業員#{n+10}",
      name_kana:           "テストサギョウイン#{n+10}",
      country:             "日本",
      my_address:          "東京都サギョウ区1-2-#{n+10}",
      my_phone_number:     '01234567898',
      family_address:      "千葉県サギョウ区1-2-#{n+10}",
      family_phone_number: '01234567898',
      birth_day_on:        '2000-01-01',
      abo_blood_type:      0,
      rh_blood_type:       0,
      job_title:            '係員',
      hiring_on:           '2022-01-01',
      experience_term_before_hiring: 1,
      blank_term:          1
    }
  )
end

3.times do |n|
  Worker.seed(:id,
    {
      id: n+13,
      business_id:         5,
      uuid:                 SecureRandom.uuid,
      name:                "テスト作業員#{n+13}",
      name_kana:           "テストサギョウイン#{n+13}",
      country:             "日本",
      my_address:          "東京都サギョウ区1-2-#{n+13}",
      my_phone_number:     '01234567898',
      family_address:      "千葉県サギョウ区1-2-#{n+13}",
      family_phone_number: '01234567898',
      birth_day_on:        '2000-01-01',
      abo_blood_type:      0,
      rh_blood_type:       0,
      job_title:            '係員',
      hiring_on:           '2022-01-01',
      experience_term_before_hiring: 1,
      blank_term:          1
    }
  )
end
