class CarLiabilityInsurance < ApplicationRecord
  belongs_to :car, dependent: :destroy
  belongs_to :car_insurance_company, dependent: :destroy

  validates :car_id, uniqueness: true
end
