class WorkerSpecialEducation < ApplicationRecord
  belongs_to :worker
  belongs_to :special_education
  mount_uploaders :images, WorkerSpecialEducationsUploader

  validates :got_on, presence: true
  validates :worker_id, uniqueness: { scope: :special_education_id }
end
