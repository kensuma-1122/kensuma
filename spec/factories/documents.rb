FactoryBot.define do
  factory :document do
    uuid { SecureRandom.uuid }
    document_type { 0 }
    created_on { '2022-03-08' }
    submitted_on { '2022-03-08' }
    content { }
    business
    request_order

    # 表紙
    trait :cover do
      document_type { 0 }
      content do
        {
          'business_name': 'test1',
          'submitted_on':  '2022-01-01'
        }
      end
    end

    # 目次
    trait :table do
      document_type { 1 }
      content { {} }
    end

    # 施工体制台帳作成建設工事の通知
    trait :doc_2nd do
      document_type { 2 }
      content do
        {
          'submitted_on':           '2022-01-01',
          'prime_contractor_name':  'test1',
          'site_name':              'test2',
          'business_name':          'test3',
          'orderer_name':           'test4',
          'construction_name':      'test5',
          'supervisor_name':        'test6',
          'apply':                  'test7',
          'submission_destination': 'test8'
        }
      end
    end

    # 作業員名簿
    trait :doc_5th do
      document_type { 5 }
      content do
        {
          'doc5_8_001_business_name':         'test1',
          'doc5_8_002_site_id':               'test2',
          'doc5_8_003_site_agent':            'test3',
          'doc5_8_004_created_date':          '2020-0101',
          'doc5_8_005_primary_business_name': 'test5',
          'doc5_8_006_primary_business_id':   'test6',
          'doc5_8_007_hierarchy':             'test7',
          'doc5_8_009_my_business_name':      'test9',
          'doc5_8_010_my_business_id':        'test10',
          'doc5_8_011_submitted_on':          '2020-01-01',
          'doc5_8_042_confirmation':          'test42',
          'worker':                           ['{
                                                  "id":1,
                                                  "name":"サンプル作業員",
                                                  "name_kana":"サンプルサギョウイン",
                                                  "country":"日本",
                                                  "my_address":"東京都港区1-1",
                                                  "my_phone_number":"01234567898",
                                                  "family_address":"埼玉県三郷市1-1",
                                                  "family_phone_number":"09876543210",
                                                  "birth_day_on":"2000-01-28",
                                                  "abo_blood_type":"a",
                                                  "rh_blood_type":"plus",
                                                  "job_type":0,
                                                  "hiring_on":"2022-01-28",
                                                  "experience_term_before_hiring":10,
                                                  "blank_term":3,
                                                  "carrier_up_id":"1",
                                                  "business_id":1,
                                                  "worker_medical": {
                                                                      "med_exam_on":"2022-03-01",
                                                                      "max_blood_pressure":120,
                                                                      "min_blood_pressure":70,
                                                                      "special_med_exam_on":"2022-03-01"
                                                                    },
                                                  "worker_insurance": {
                                                                        "health_insurance_type": "health_insurance_association",
                                                                        "health_insurance_name": "サンプル健康保険",
                                                                        "pension_insurance_type": "welfare",
                                                                        "employment_insurance_type": "insured",
                                                                        "employment_insurance_number": "0000",
                                                                        "severance_pay_mutual_aid_type": "kentaikyo",
                                                                        "severance_pay_mutual_aid_name": "テスト共済制度"
                                                                      },
                                                  "worker_skill_trainings": [{ "skill_training_id": 2 }],
                                                  "worker_special_educations": [{ "special_education_id": 3 }],
                                                  "worker_licenses": [{ "license_id": 1 } ]
                                                }']
        }
      end
    end
  end
end
