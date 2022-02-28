class WorkerSkillTraining < ApplicationRecord
  belongs_to :worker
  belongs_to :skill_training
  mount_uploaders :images, WorkerSkillTrainingsUploader

  validates :got_on, presence: true
  validates :worker_id, uniqueness: { scope: :skill_training_id }
end
