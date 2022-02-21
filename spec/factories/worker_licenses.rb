FactoryBot.define do
  factory :worker_license do
    got_on { '2022-02-12' }
    images { '' }
    worker
    license
  end
end
