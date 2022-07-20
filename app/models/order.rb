class Order < ApplicationRecord
  belongs_to :business
  has_many :request_orders, dependent: :destroy

  enum status: { created: 0, completed: 1 }
  enum supervising_engineer_check: { full_time: 0, non_dedicated: 1 }

  validates :status,                                 presence: true
  validates :site_name,                              presence: true # 事業所名(現場名)
  validates :site_address,                           presence: true # 施工場所(住所)
  validates :order_name,                             presence: true # 発注者(会社名or氏名)
  validates :order_post_code,                        presence: true, format: { with: /\A\^\d{5}$|^\d{7}\z/ } # 発注者(郵便番号)
  validates :order_address,                          presence: true # 発注者(住所)
  validates :order_supervisor_name,                  presence: true # 監督員(氏名)
  validates :order_supervisor_apply,                 presence: true # 監督員(権限及び意見の申出方法)
  validates :construction_name,                      presence: true # 工事名
  validates :construction_details,                   presence: true # 工事内容
  validates :start_date,                             presence: true # 工期(自)
  validates :end_date,                               presence: true # 工期(至)
  validates :contract_date,                          presence: true # 契約日
  validates :submission_destination,                 presence: true # 提出先及び担当者(部署･氏名)
  validates :general_safety_responsible_person_name, presence: true # 統括安全衛生責任者(氏名)
  validates :vice_president_name,                    presence: true # 副会長(氏名)
  validates :vice_president_company_name,            presence: true # 副会長(会社名)
  validates :secretary_name,                         presence: true # 書記(氏名)
  validates :health_and_safety_manager_name,         presence: true # 元方安全衛生管理者(氏名)
  validates :general_safety_agent_name,              presence: true # 統括安全衛生責任者代行者(氏名)
  validates :supervisor_name,                        presence: true # 監督員(氏名)
  validates :supervisor_apply,                       presence: true # 監督員(権限及び意見の申出方法)
  validates :site_agent_name,                        presence: true # 現場代理人(氏名)
  validates :site_agent_apply,                       presence: true # 現場代理人(権限及び意見の申出方法)
  validates :supervising_engineer_name,              presence: true # 監督技術者･主任技術者(氏名)
  validates :supervising_engineer_check,             presence: true # 監督技術者・主任技術者(専任or非専任)
  validates :safety_officer_name,                    presence: true # 安全衛生担当役員(氏名)
  validates :safety_officer_position_name,           presence: true # 安全衛生担当役員(役職名)
  validates :confirm_name,                           presence: true # 確認欄(氏名)
  validates :accept_confirm_date,                    presence: true # 受付確認(年月日)
  validates :subcontractor_name,                     presence: true # 下請会社名

  before_create -> { self.site_uu_id = SecureRandom.uuid }

  def to_param
    site_uu_id
  end
end
