require 'rails_helper'

RSpec.describe CarInsuranceCompany, type: :model do
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
end
