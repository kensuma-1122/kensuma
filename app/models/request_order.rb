class RequestOrder < ApplicationRecord
  has_closure_tree
  
  belongs_to :order

  enum status: { editing: 0, completed: 1, request: 2 }

  validates :status, presence: true
  validates :business_id, presence: true
end
