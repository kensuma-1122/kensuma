class RequestOrder < ApplicationRecord
  belongs_to :order
  belongs_to :business
  has_many :documents, dependent: :destroy

  enum status: { requested: 0, submitted: 1, fix_requested: 2, approved: 3 }

  has_closure_tree

  before_create -> { self.uuid = SecureRandom.uuid }

  def to_param
    uuid
  end
end
