class Document < ApplicationRecord
  has_one :cover_documents

  before_create -> { self.uuid = SecureRandom.uuid }

  def to_param
    uuid
  end
end
