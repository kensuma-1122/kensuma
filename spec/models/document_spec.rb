require 'rails_helper'

RSpec.describe Document, type: :model do
  let(:document) { build(:document) }

  describe 'documentの生成と保存' do
    it 'documentが保存されること' do
      document.save!
      expect(subject).to be_valid
    end
  end
end
