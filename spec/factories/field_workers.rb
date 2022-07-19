FactoryBot.define do
  factory :order_field_worker, class: 'FieldWorker' do
    field_workerable_type { 'Order' }
    field_workerable_id { 1 }
    association :field_workerable, factory: :order
    uuid { SecureRandom.uuid }
    sequence(:admission_worker_name) { |n| "admission_worker_name#{n}" }
    sequence(:content) { |n| { "id": n + 1 } }
  end

  factory :request_order_field_worker, class: 'FieldWorker' do
    field_workerable_type { 'RequestOrder' }
    field_workerable_id { 2 }
    association :field_workerable, factory: :request_order
    uuid { SecureRandom.uuid }
    sequence(:admission_worker_name) { |n| "admission_worker_name#{n}" }
    sequence(:content) { |n| { "id": n + 1 } }
  end
end
