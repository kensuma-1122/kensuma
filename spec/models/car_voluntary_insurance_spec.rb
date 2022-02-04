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

    it 'car_idがない場合、無効であること' do
      subject.car_id = nil
      expect(subject).to be_invalid
    end

    it 'car_insurance_company_idがない場合、無効であること' do
      subject.car_insurance_company_id = nil
      expect(subject).to be_invalid
    end

    describe '#personal_insurance' do
      context '存在しない場合' do
        before :each do
          subject.personal_insurance = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end
  end
end
