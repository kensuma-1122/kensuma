class RequestOrder < ApplicationRecord
  # ↓ツリー構造追加時に使用
  # has_closure_tree

  belongs_to :business
  belongs_to :order

  enum status: { editing: 0, completed: 1, request: 2 }

  validates :status, presence: true
end
