class Business < ApplicationRecord
  belongs_to :user

  before_validation :set_uuid

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :uuid, presence: true
  validates :name, presence: true
  validates :name_kana, presence: true
  validates :branch_name, presence: true
  validates :representative_name, presence: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :address, presence: true
  validates :post_code, presence: true
  validates :phone_number, presence: true
  validates :business_type, presence: true

  enum business_type: { corporation: 0, freelance: 1, Individual_five_over: 2, Individual_five_less: 3 }

  private

    def set_uuid
      self.uuid = SecureRandom.uuid if self.uuid.nil?
    end
end
