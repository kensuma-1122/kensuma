require 'rails_helper'

RSpec.describe CarVoluntaryInsurance, type: :model do
  let(:car) { create(:car) }
  let(:car_insurance_company) { create(:car_insurance_company) }
  let(:car_voluntary_insurance) { create(:car_voluntary_insurance, company_voluntary: car_insurance_company, car_voluntary: car) }

  describe 'バリデーションについて' do
    subject do
      car_voluntary_insurance
    end

    it 'バリデーションが通ること' do
      expect(subject).to be_valid
    end

    describe '#car_voluntary_id' do
      context '存在しない場合' do
        before :each do
          subject.car_voluntary_id = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#company_voluntary_id' do
      context '存在しない場合' do
        before :each do
          subject.company_voluntary_id = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#personal_insurance' do
      context '存在しない場合' do
        before :each do
          subject.personal_insurance = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
          subject.valid?
          expect(subject.errors.full_messages).to include('対人保険金を入力してください')
        end
      end
    end

    describe '#objective_insurance' do
      context '存在しない場合' do
        before :each do
          subject.objective_insurance = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
          subject.valid?
          expect(subject.errors.full_messages).to include('対物保険金を入力してください')
        end
      end
    end

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

      context 'Carモデルとの関連付け' do
        let(:target) { :car_voluntary }

        it 'belongs_toであること' do
          expect(association.macro).to eq :belongs_to
        end
      end

      context 'CarInsuranceCompanyモデルとの関連付け' do
        let(:target) { :company_voluntary }

        it 'belongs_toであること' do
          expect(association.macro).to eq :belongs_to
        end
      end
    end
  end
end
