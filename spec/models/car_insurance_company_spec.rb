require 'rails_helper'

RSpec.describe CarInsuranceCompany, type: :model do
  let :car_insurance_company do
    create(:car_insurance_company)
  end
  
  let :car do
    create(:car)
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

  describe '車両とのアソシエーションについて' do
    # let :business do
    #   create(:business, cars: cars)
    # end

    # let :cars do
    #   create_list(:car, 2)
    # end

    context '紐つく車両がある場合' do
      let :car_insurance_company do
        create(:car_insurance_company)
      end
      
      let :car do
        create(:car)
      end
      let!(:car_liability_insurance) { create(:car_liability_insurance, car: car, car_insurance_company: car_insurance_company) }
      it '一つの車両に自賠責保険が2件以上保存されないこと' do
        car_liability_insurance = build(:liability, car: car, car_insurance_company: car_insurance_company)
        car_liability_insurance.valid?
        expect(liability_car.errors[:car_insurance_company_id]).to include("はすでに存在します。")
      end
      # subject do
      #   company.car_voluntaries
      # end

      # it '紐つく車両を返すこと' do
      #   expect(subject).to eq(cars)
      # end
    end
  end
end
