class SkillTraining < ApplicationRecord
  has_many :workers, through: :worker_skill_trainings
  has_many :worker_skill_trainings, dependent: :destroy

  validates :name, presence: true
  validates :short_name, presence: true
end
