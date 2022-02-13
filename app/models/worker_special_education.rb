class WorkerSpecialEducation < ApplicationRecord
  belongs_to :worker
  belongs_to :special_education

  validates :got_on, presence: true
end
