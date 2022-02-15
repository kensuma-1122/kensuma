class License < ApplicationRecord
  has_many :workers, through: :worker_licenses
  has_many :worker_licenses, dependent: :destroy
end
