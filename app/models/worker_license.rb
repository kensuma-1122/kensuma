class WorkerLicense < ApplicationRecord
  belongs_to :worker
  belongs_to :license

  validates :got_on, presence: true
  validates :worker_id, uniqueness: { scope: :license_id }

  mount_uploaders :images, WorkerLicensesUploader
end
