class Machine < ApplicationRecord
  belongs_to :business

  before_create -> { self.uuid = SecureRandom.uuid }

  def to_param
    uuid
  end
end
