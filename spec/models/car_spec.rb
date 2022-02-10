require 'rails_helper'

RSpec.describe Car, type: :model do
  let(:car) { create(:car) }

  describe 'バリデーションについて' do
    subject do
      car
    end

    it 'バリデーションが通ること' do
      expect(subject).to be_valid
    end

    describe '#owner_name' do
      context '存在しない場合' do
        before :each do
          subject.owner_name = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('車両所有者氏名を入力してください')
        end
      end
    end

    describe '#vehicle_model' do
      context '存在しない場合' do
        before :each do
          subject.vehicle_model = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('車両型式を入力してください')
        end
      end
    end

    describe '#vehicle_number' do
      context '存在しない場合' do
        before :each do
          subject.vehicle_number = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('車両番号を入力してください')
        end
      end
    end

    describe '#vehicle_inspection_start_on' do
      context '存在しない場合' do
        before :each do
          subject.vehicle_inspection_start_on = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('車検初めを入力してください')
        end
      end
    end

    describe '#vehicle_inspection_end_on' do
      context '存在しない場合' do
        before :each do
          subject.vehicle_inspection_end_on = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('車検終わりを入力してください')
        end
      end
    end

    describe '#liability_securities_number' do
      context '存在しない場合' do
        before :each do
          subject.liability_securities_number = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('自賠責証券番号を入力してください')
        end
      end
    end

    describe '#liability_insurance_start_on' do
      context '存在しない場合' do
        before :each do
          subject.liability_insurance_start_on = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('自賠責保険初めを入力してください')
        end
      end
    end

    describe '#liability_insurance_end_on' do
      context '存在しない場合' do
        before :each do
          subject.liability_insurance_end_on = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('自賠責保険終わりを入力してください')
        end
      end
    end
  end

  describe '保険会社(自賠責,任意)とのアソシエーションについて' do
    let :liability_company do
      create(:car_insurance_company) # 自賠責保険会社
    end

    let :voluntary_companies do
      create_list(:car_insurance_company, 2) # 任意保険会社
    end

    context '紐つく自賠責保険会社がある場合' do
      subject do
        car.car_insurance_company = liability_company
      end

      it '紐つく自賠保険会社を返すこと' do
        expect(subject).to eq(liability_company)
      end
    end

    context '紐つく任意保険会社がある場合' do
      subject do
        car.company_voluntaries << voluntary_companies
      end

      it '紐つく任意保険会社を返すこと' do
        expect(subject).to eq(voluntary_companies)
      end
    end
  end

  describe '関連付けについて' do
    let(:association) { described_class.reflect_on_association(target) }

    context 'car_insurance_companyモデルとの関連付け' do
      let(:target) { :car_insurance_company }

      it 'has_manyであること' do
        expect(association.macro).to eq :belongs_to
      end
    end

    context '自賠責経由でのcar_insurance_companyモデルとの関連付け' do
      let(:target) { :company_voluntaries }

      it 'has_manyであること' do
        expect(association.macro).to eq :has_many
      end
    end
  end
end
