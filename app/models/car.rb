class Car < ApplicationRecord
  belongs_to :business
  has_many :car_insurance_companies, through: :car_voluntary_insurances
  has_many :car_voluntary_insurances, dependent: :destroy
  # has_many :car_voluntary_insurances, class_name: 'CarVoluntaryInsurance', foreign_key: :car_voluntary_id, dependent: :destroy
  # has_many :company_voluntaries, through: :car_voluntary_insurances, source: :company_voluntary

  mount_uploaders :images, ImagesUploader

  validates :owner_name, presence: true
  validates :vehicle_model, presence: true
  validates :vehicle_number, presence: true
  validates :vehicle_inspection_start_on, presence: true
  validates :vehicle_inspection_end_on, presence: true
  validates :liability_securities_number, presence: true
  validates :liability_insurance_start_on, presence: true
  validates :liability_insurance_end_on, presence: true
end
