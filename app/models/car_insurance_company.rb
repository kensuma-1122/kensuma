class CarInsuranceCompany < ApplicationRecord
  has_many :car_voluntary_insurances, dependent: :destroy
  has_many :cars

  validates :name, presence: true
end
