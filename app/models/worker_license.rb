class WorkerLicense < ApplicationRecord
  belongs_to :worker
  belongs_to :license

  validates :worker_id, uniqueness: { scope: :license_id }
end
