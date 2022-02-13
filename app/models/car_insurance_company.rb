class CarInsuranceCompany < ApplicationRecord
  has_many :cars
  has_many :car_voluntary_insurances, class_name: 'CarVoluntaryInsurance', foreign_key: :company_voluntary_id, dependent: :destroy
  has_many :car_voluntaries, through: :car_voluntary_insurances, source: :car_voluntary
  accepts_nested_attributes_for :car_voluntary_insurances, allow_destroy: true

  validates :name, presence: true
end
