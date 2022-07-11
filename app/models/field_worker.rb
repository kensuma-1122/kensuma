class FieldWorker < ApplicationRecord
  belongs_to :field_workerable, polymorphic: true
end
