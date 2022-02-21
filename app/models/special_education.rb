class SpecialEducation < ApplicationRecord
  has_many :worker_special_educations, dependent: :destroy
  has_many :workers, through: :worker_special_educations

  validates :name, presence: true
end
