class Occupation < ApplicationRecord
  has_many :business_occupations
  has_many :business, through: :business_occupations
end
