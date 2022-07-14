class Solvent < ApplicationRecord
  belongs_to :business

  validates :uuid, presence: true
  validates :name, presence: true
  validates :maker, presence: true
  validates :classification, presence: true
  validates :ingredients, presence: true  
end
