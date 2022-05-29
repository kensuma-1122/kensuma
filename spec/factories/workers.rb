FactoryBot.define do
  factory :worker do
    association :business
    uuid { SecureRandom.uuid }
    name { 'TestWorker' }
    name_kana { 'テストワーカー' }
    country { '日本' }
    my_address { '東京都' }
    my_phone_number { '09012345678' }
    family_address { '東京都' }
    family_phone_number { '08087654321' }
    birth_day_on { '2022-01-28' }
    abo_blood_type { 0 }
    rh_blood_type { 0 }
    job_type { 0 }
    hiring_on { '2022-01-28' }
    experience_term_before_hiring { 1 }
    blank_term { 1 }
    carrier_up_id { '1' }
    images { '' }

    after(:create) do |worker|
      create_list(:worker_license, 1, worker: worker, license: License.create!(name: 'テストライセンス', license_type: 0))
      create_list(:worker_skill_training, 1, worker: worker, skill_training: SkillTraining.create!(name: 'テスト技能講習', short_name: 'テス技'))
      create_list(:worker_special_education, 1, worker: worker, special_education: SpecialEducation.create!(name: 'テスト特別教育'))
      create_list(:worker_insurance, 1, worker: worker)
    end
  end
end
