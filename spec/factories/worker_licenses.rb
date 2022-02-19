FactoryBot.define do
  factory :worker_license do
    got_on { '2022-01-01' }
    images { '' }
    worker
    license
  end
end
