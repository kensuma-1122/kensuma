class Worker < ApplicationRecord
  belongs_to :business
  has_one :worker_insurance, dependent: :destroy

  has_many :worker_licenses, dependent: :destroy
  has_many :licenses, through: :worker_licenses
  accepts_nested_attributes_for :worker_licenses,
    reject_if:     proc { |attributes| attributes['license_id'].blank? }

  has_many :worker_skill_trainings, dependent: :destroy
  has_many :skill_trainings, through: :worker_skill_trainings
  accepts_nested_attributes_for :worker_skill_trainings,
    reject_if:     proc { |attributes| attributes['skill_training_id'].blank? }

  has_many :worker_special_educations, dependent: :destroy
  has_many :special_educations, through: :worker_special_educations
  accepts_nested_attributes_for :worker_special_educations,
    reject_if:     proc { |attributes| attributes['special_education_id'].blank? }

  enum abo_blood_type: { a: 0, b: 1, ab: 2, o: 3 }
  enum rh_blood_type: { plus: 0, minus: 1 }
  # ↓内訳未定のためコメントアウト
  # enum job_type: {  }

  VALID_PHONE_NUMBER_REGEX = /\A\d{10,11}\z/
  validates :name, presence: true
  validates :name_kana, presence: true, format: { with: /\A[ァ-ヴー]+\z/u, message: 'はカタカナで入力してください' }
  validates :country, presence: true
  validates :my_address, presence: true
  validates :my_phone_number, presence: true, format: { with: VALID_PHONE_NUMBER_REGEX, message: 'はハイフン無しの10桁または11桁で入力してください' }
  validates :family_address, presence: true
  validates :family_phone_number, presence: true, format: { with: VALID_PHONE_NUMBER_REGEX, message: 'はハイフン無しの10桁または11桁で入力してください' }
  validates :birth_day_on, presence: true
  validates :abo_blood_type, presence: true
  validates :rh_blood_type, presence: true
  validates :job_type, presence: true
  validates :hiring_on, presence: true
  validates :experience_term_before_hiring, presence: true
  validates :blank_term, presence: true
end
