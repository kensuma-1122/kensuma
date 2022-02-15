class RegisteredCoreTechnician < ApplicationRecord
  has_many :workers, through: :worker_registered_core_technicians
  has_many :worker_registered_core_technicians, dependent: :destroy
end
