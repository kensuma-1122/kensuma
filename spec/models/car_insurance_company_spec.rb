require 'rails_helper'

RSpec.describe CarInsuranceCompany, type: :model do
  let(:cars) { create_list(:car, 2) }
  let(:car_insurance_company) { create(:car_insurance_company) }

  describe 'バリデーションについて' do
    subject do
      car_insurance_company
    end

    it 'バリデーションが通ること' do
      expect(subject).to be_valid
    end

    describe '#car_insurance_company' do
      context '存在しない場合' do
        before :each do
          subject.name = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
          expect(subject.errors.full_messages).to include('保険会社名を入力してください')
        end
      end
    end
  end

  describe 'アソシエーションについて' do
    context '自賠責テーブル経由で紐つく車両がある場合' do
      subject do
        car_insurance_company.car_voluntaries << cars
      end

      it '紐つく車両を返すこと' do
        expect(subject).to eq(cars)
      end
    end
  end

  describe '関連付けについて' do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context 'Carモデルとの関連付け' do
      let(:target) { :cars }

      it 'has_manyであること' do
        expect(association.macro).to eq :has_many
      end
    end

    context '自賠責経由でのCarモデルとの関連付け' do
      let(:target) { :car_voluntaries }

      it 'has_manyであること' do
        expect(association.macro).to eq :has_many
      end
    end
  end
end
