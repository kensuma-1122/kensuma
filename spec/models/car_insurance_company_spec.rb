require 'rails_helper'

RSpec.describe CarInsuranceCompany, type: :model do
  let :car_insurance_company do
    create(:car_insurance_company)
  end

  describe 'バリデーションについて' do
    subject do
      car_insurance_company
    end

    it 'バリデーションが通ること' do
      expect(subject).to be_valid
    end

    it '保険会社名が無い場合、無効であること' do
      subject.name = nil
      expect(subject).to be_invalid
      expect(subject.errors.full_messages).to include('保険会社名を入力してください')
    end
  end
end
