class CarInsuranceCompany < ApplicationRecord
  has_many :car_liability_insurances, class_name: 'CarLiabilityInsurance', foreign_key: :company_liability_id, dependent: :destroy
  has_many :car_liabilities, through: :car_liability_insurances, source: :car_liability
  has_many :car_voluntary_insurances, class_name: 'CarVoluntaryInsurance', foreign_key: :company_voluntary_id, dependent: :destroy
  has_many :car_voluntaries, through: :car_voluntary_insurances, source: :car_voluntary

  validates :name, presence: true
end
