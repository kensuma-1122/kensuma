class WorkerRegisteredCoreTechnician < ApplicationRecord
  belongs_to :worker
  belongs_to :registered_core_technician

  validates :worker_id, uniqueness: { scope: :core_technician_id }
end
