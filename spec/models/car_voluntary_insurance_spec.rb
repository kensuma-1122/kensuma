require 'rails_helper'

RSpec.describe CarVoluntaryInsurance, type: :model do
  let(:car) { create(:car) }
  let(:car_insurance_company) { create(:car_insurance_company) }
  let(:car_voluntary_insurance) { create(:car_voluntary_insurance, car_voluntary: car, company_voluntary: car_insurance_company) }

  describe 'アソシエーションについて' do
    context '紐つく車両がある場合' do
      subject do
        car_voluntary_insurance.car_voluntary
      end

      it '紐つく車両を返すこと' do
        expect(subject).to eq(car)
      end
    end

    context '紐つく保険会社がある場合' do
      subject do
        car_voluntary_insurance.company_voluntary
      end

      it '紐つく保険会社を返すこと' do
        expect(subject).to eq(car_insurance_company)
      end
    end
  end

  describe '関連付けについて' do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context 'Carモデル側との関連付け' do
      let(:target) { :car_voluntary }

      it 'belongs_toであること' do
        expect(association.macro).to eq :belongs_to
      end
    end

    context 'CarInsuranceCompanyモデル側との関連付け' do
      let(:target) { :company_voluntary }

      it 'belongs_toであること' do
        expect(association.macro).to eq :belongs_to
      end
    end
  end
end
