class RequestOrder < ApplicationRecord
  belongs_to :order

  enum status: { editing: 0, completed: 1, request: 2 }
end
