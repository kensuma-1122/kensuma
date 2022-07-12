class FieldWorker < ApplicationRecord
  belongs_to :field_workerable, polymorphic: true

  validates :admission_worker_name, presence: true
  validates :admission_date_start, presence: true
  validates :admission_date_end, presence: true
  validates :education_date, presence: true
end
