class FieldWorker < ApplicationRecord
  belongs_to :field_workerable, polymorphic: true

  before_create -> { self.uuid = SecureRandom.uuid }

  validates :admission_worker_name, presence: true
  validates :admission_date_start, presence: true
  validates :admission_date_end, presence: true
  validates :education_date, presence: true

  def to_param
    uuid
  end
end
