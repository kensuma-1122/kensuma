class Document < ApplicationRecord
  has_one :cover_document, dependent: :destroy

  before_create -> { self.uuid = SecureRandom.uuid }

  def to_param
    uuid
  end
end
