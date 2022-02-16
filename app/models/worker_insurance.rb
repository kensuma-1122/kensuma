class WorkerInsurance < ApplicationRecord
  belongs_to :worker

  enum health_insurance_type: {
    health_insurance_association: 0, japan_health_insurance_association: 1,
    construction_national_health_insurance: 2, national_health_insurance: 3, exemption: 4
  }, _prefix: true
  enum pension_insurance_type: { welfare: 0, national: 1, recipient: 2 }
  enum employment_insurance_type: { insured: 0, day: 1, exemption: 2 }, _prefix: true
  enum severance_pay_mutual_aid_type: { kentaikyo: 0, tyutaikyo: 1, other: 2, none: 3 }, _prefix: true

  VALID_EMPLOYMENT_INSURANCE_NUMBER_REGEX = /\A[0-9]{4}$+\z/
  validates :health_insurance_type, presence: true
  validates :pension_insurance_type, presence: true
  validates :employment_insurance_type, presence: true
  validates :employment_insurance_number, format: { with: VALID_EMPLOYMENT_INSURANCE_NUMBER_REGEX, message: 'は半角数字4桁で入力してください' }, allow_nil: true
  validates :severance_pay_mutual_aid_type, presence: true
end
