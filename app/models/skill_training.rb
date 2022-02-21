class SkillTraining < ApplicationRecord
  has_many :worker_skill_trainings, dependent: :destroy
  has_many :workers, through: :worker_licenses

  validates :name, presence: true
  validates :short_name, presence: true
end
