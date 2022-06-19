class Order < ApplicationRecord
  belongs_to :business
  has_many :request_orders, dependent: :destroy

  enum status: { created: 0, completed: 1 }
  enum supervising_engineer_check: { full_time: 0, non_dedicated: 1 }

  validates :status, presence: true
  validates :site_name, presence: true
  validates :site_address, presence: true
  validates :order_name, presence: true
  validates :order_post_code, presence: true, format: { with: /\A\^\d{5}$|^\d{7}\z/ }
  validates :order_address, presence: true
  validates :order_supervisor_name, presence: true
  validates :order_supervisor_apply, presence: true
  validates :construction_name, presence: true
  validates :construction_details, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :contract_date, presence: true
  validates :submission_destination, presence: true
  validates :general_safety_responsible_person_name, presence: true
  validates :vice_president_name, presence: true
  validates :vice_president_company_name, presence: true
  validates :secretary_name, presence: true
  validates :health_and_safety_manager_name, presence: true
  validates :general_safety_agent_name, presence: true
  validates :supervisor_name, presence: true
  validates :supervisor_apply, presence: true
  validates :site_agent_name, presence: true
  validates :site_agent_apply, presence: true
  validates :supervising_engineer_name, presence: true
  validates :supervising_engineer_check, presence: true
  validates :safety_officer_name, presence: true
  validates :safety_officer_position_name, presence: true
  validates :confirm_name, presence: true
  validates :accept_confirm_date, presence: true
  validates :subcontractor_name, presence: true

  before_create -> { self.site_uu_id = SecureRandom.uuid }

  def to_param
    site_uu_id
  end
end
