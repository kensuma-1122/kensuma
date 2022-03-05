class RequestOrder < ApplicationRecord
  belongs_to :order
  belongs_to :business

  enum status: { editing: 0, completed: 1, request: 2 }

  has_closure_tree

  before_create -> { self.uuid = SecureRandom.uuid }

  def to_param
    uuid
  end
end
