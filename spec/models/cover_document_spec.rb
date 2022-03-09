require 'rails_helper'

RSpec.describe CoverDocument, type: :model do
  let(:document) { build(:document) }
  let(:cover_document) { build(:cover_document, document: document) }

  describe 'documentとcover_documentの生成と保存' do
    it 'documentとcover_documentが保存されること' do
      cover_document.save!
      expect(document).to be_valid
      expect(cover_document).to be_valid
    end
  end
end
