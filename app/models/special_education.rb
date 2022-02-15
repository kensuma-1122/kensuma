class SpecialEducation < ApplicationRecord
  has_many :workers, through: :worker_special_educations
  has_many :worker_special_educations, dependent: :destroy
end
