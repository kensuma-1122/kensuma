require 'rails_helper'

RSpec.describe CarLiabilityInsurance, type: :model do
  let :car_liability_insurance do
    create(:car_liability_insurance)
  end

  describe 'バリデーションについて' do
    subject do
      car_liability_insurance
    end

    it 'car_idとcar_insurance_company_idがある場合、有効であること' do
      expect(subject).to be_valid
    end

    it 'car_idがない場合、無効であること' do
      subject.car_id = nil
      expect(subject).to be_invalid
    end

    it 'car_insurance_company_idがない場合、無効であること' do
      subject.car_insurance_company_id = nil
      expect(subject).to be_invalid
    end
  end
end
