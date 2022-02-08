require 'rails_helper'

RSpec.describe CarLiabilityInsurance, type: :model do
  let(:car) { create(:car) }
  let(:car_insurance_company) { create(:car_insurance_company) }
  let(:car_liability_insurance) { create(:car_liability_insurance, company_liability: car_insurance_company, car_liability: car) }

  describe 'バリデーションについて' do
    subject do
      car_liability_insurance
    end

    it 'バリデーションが通ること' do
      expect(subject).to be_valid
    end

    describe '#car_liability_id' do
      context '存在しない場合' do
        before :each do
          subject.car_liability_id = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#company_liability_id' do
      context '存在しない場合' do
        before :each do
          subject.company_liability_id = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end
  end

  describe 'アソシエーションについて' do
    context '紐つく車両がある場合' do
      subject do
        car_liability_insurance.car_liability
      end

      it '紐つく車両を返すこと' do
        expect(subject).to eq(car)
      end
    end

    context '紐つく保険会社がある場合' do
      subject do
        car_liability_insurance.company_liability
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

    context 'Carモデルとの関連付け' do
      let(:target) { :car_liability }

      it 'belongs_toであること' do
        expect(association.macro).to eq :belongs_to
      end
    end

    context 'CarInsuranceCompanyモデルとの関連付け' do
      let(:target) { :company_liability }

      it 'belongs_toであること' do
        expect(association.macro).to eq :belongs_to
      end
    end
  end
end
