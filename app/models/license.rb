class License < ApplicationRecord
  has_many :worker_licenses, dependent: :destroy
  has_many :workers, through: :worker_licenses

  enum license_type: {
    登録基幹技能者: 0,
    建設業法: 1, 建築士法: 2, 技術士法: 3, 電気工事士法: 4, 電気事業法: 5,
    電気通信事業法: 6, 水道法: 7, 消防法: 8, 職業能力開発促進法: 9, その他: 10
  }

  validates :name, presence: true
  validates :license_type, presence: true
end
