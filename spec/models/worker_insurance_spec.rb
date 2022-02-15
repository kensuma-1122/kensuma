require 'rails_helper'

RSpec.describe WorkerInsurance, type: :model do
  let(:worker_insurance) { build(:worker_insurance) }

  describe 'バリデーションについて' do
    subject { worker_insurance }

    it 'バリデーションが通ること' do
      expect(subject).to be_valid
    end

    describe '#health_insurance_type' do
      context '存在しない場合' do
        before(:each) { subject.health_insurance_type = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
          subject.valid?
          expect(subject.errors.full_messages).to include('健康保険を入力してください')
        end
      end
    end

    describe '#pension_insurance_type' do
      context '存在しない場合' do
        before(:each) { subject.pension_insurance_type = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
          subject.valid?
          expect(subject.errors.full_messages).to include('年金保険を入力してください')
        end
      end
    end

    describe '#employment_insurance_type' do
      context '存在しない場合' do
        before(:each) { subject.employment_insurance_type = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
          subject.valid?
          expect(subject.errors.full_messages).to include('雇用保険を入力してください')
        end
      end
    end

    describe '#employment_insurance_number' do
      context '存在しない場合' do
        before(:each) { subject.employment_insurance_number = nil }

        it 'nilを許容すること' do
          expect(subject).to be_valid
        end
      end

      context '3桁の場合' do
        before(:each) { subject.employment_insurance_number = '1' * 3 }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
          subject.valid?
          expect(subject.errors.full_messages).to include('被保険者番号(下4桁)は半角数字4桁で入力してください')
        end
      end

      context '5桁の場合' do
        before(:each) { subject.employment_insurance_number = '1' * 5 }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
          subject.valid?
          expect(subject.errors.full_messages).to include('被保険者番号(下4桁)は半角数字4桁で入力してください')
        end
      end

      %i[abcd ああああ 一二三四 a123 1-23].each do |employment_insurance_number|
        context '数字以外の場合' do
          before(:each) { subject.employment_insurance_number = employment_insurance_number }

          it 'バリデーションに落ちること' do
            expect(subject).to be_invalid
            subject.valid?
            expect(subject.errors.full_messages).to include('被保険者番号(下4桁)は半角数字4桁で入力してください')
          end
        end
      end
    end

    describe '#severance_pay_mutual_aid_type' do
      context '存在しない場合' do
        before(:each) { subject.severance_pay_mutual_aid_type = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
          subject.valid?
          expect(subject.errors.full_messages).to include('建設業退職⾦共済制度を入力してください')
        end
      end
    end
  end
end
