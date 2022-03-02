class RequestOrder < ApplicationRecord
  belongs_to :business
  belongs_to :order

  enum status: { editing: 0, completed: 1, request: 2 }

  validates :status, presence: true

  has_closure_tree
end
