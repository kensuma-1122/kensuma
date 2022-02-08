class CarLiabilityInsurance < ApplicationRecord
  belongs_to :car_liability, class_name: 'Car', foreign_key: 'car_liability_id'
  belongs_to :company_liability, class_name: 'CarInsuranceCompany', foreign_key: 'company_liability_id'

  validates :car_liability_id, uniqueness: true # 自賠責の車両idは1件のみの登録にするため
end
