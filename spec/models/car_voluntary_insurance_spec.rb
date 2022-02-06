require 'rails_helper'

RSpec.describe CarVoluntaryInsurance, type: :model do
  let :car_voluntary_insurance do
    create(:car_voluntary_insurance)
  end

  describe 'バリデーションについて' do
    subject do
      car_voluntary_insurance
    end

    it 'バリデーションが通ること' do
      expect(subject).to be_valid
    end

    describe '#car_id' do
      context '存在しない場合' do
        before :each do
          subject.car_id = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#car_insurance_company_id' do
      context '存在しない場合' do
        before :each do
          subject.car_insurance_company_id = nil
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
        end

        it 'バリデーションのエラーが正しいこと' do
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
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('対物保険金を入力してください')
        end
      end
    end

    describe 'アソシエーションテスト' do
      let(:association) do
        described_class.reflect_on_association(target)
      end

      context 'CarInsuranceCompanyモデルとのアソシエーション' do
        let(:target) { :car_insurance_company }

        it 'CarInsuranceCompanyとの関連付けはbelongs_toであること' do
          expect(association.macro).to eq :belongs_to
        end
      end

      context 'Carモデルとのアソシエーション' do
        let(:target) { :car }

        it 'Carとの関連付けはbelongs_toであること' do
          expect(association.macro).to eq :belongs_to
        end
      end
    end
  end
end
