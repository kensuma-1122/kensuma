class FieldWorker < ApplicationRecord
  belongs_to :field_workerable, polymorphic: true

  before_create -> { self.uuid = SecureRandom.uuid }

  def to_param
    uuid
  end
end
