require 'rails_helper'

RSpec.describe Business, type: :model do
  let :business do
    build(:business)
  end

  describe 'バリデーションについて' do
    subject do
      business
    end

    it 'バリデーションが通ること' do
      expect(subject).to be_valid
    end

    describe '#uuid' do
      context '存在しない場合' do
        before :each do
          subject.uuid = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('Uuidを入力してください')
        end
      end
    end

    describe '#name' do
      context '存在しない場合' do
        before :each do
          subject.name = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('Nameを入力してください')
        end
      end
    end

    describe '#name_kana' do
      context '存在しない場合' do
        before :each do
          subject.name_kana = nil
        end

        it 'バリデーションが通ること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('Name kanaを入力してください')
        end
      end
    end

    describe '#branch_name' do
      context '存在しない場合' do
        before :each do
          subject.branch_name = nil
        end

        it 'バリデーションが通ること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('Branch nameを入力してください')
        end
      end
    end

    describe '#representative_name' do
      context '存在しない場合' do
        before :each do
          subject.representative_name = nil
        end

        it 'バリデーションが通ること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('Representative nameを入力してください')
        end
      end
    end

    describe '#email' do
      context '存在しない場合' do
        before :each do
          subject.email = nil
        end

        it 'バリデーションが通ること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('Emailを入力してください')
        end
      end

      context 'uniqueでない場合' do
        before :each do
          business = create(:business)
          subject.email = business.email
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('Emailはすでに存在します')
        end
      end

      %i[
        email0.com
        あああ.com
        今井.com
        @@.com
      ].each do |email|
        context '不正なemailの場合' do
          before :each do
            subject.email = email
          end

          it 'バリデーションに落ちること' do
            expect(subject).to be_invalid
          end

          it 'バリデーションのエラーが正しいこと' do
            subject.valid?
            expect(subject.errors.full_messages).to include('Emailは不正な値です')
          end
        end
      end
    end

    describe '#address' do
      context '存在しない場合' do
        before :each do
          subject.address = nil
        end

        it 'バリデーションが通ること' do
          expect(subject).to be_valid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('住所を入力してください')
        end
      end
    end

    describe '#post_code' do
      context '存在しない場合' do
        before :each do
          subject.post_code = nil
        end

        it 'バリデーションが通ること' do
          expect(subject).to be_valid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('郵便番号を入力してください')
        end
      end
    end

    describe '#phone_number' do
      context '存在しない場合' do
        before :each do
          subject.phone_number = nil
        end

        it 'バリデーションが通ること' do
          expect(subject).to be_valid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('電話番号を入力してください')
        end
      end
    end

    describe '#business_type' do
      context '存在しない場合' do
        before :each do
          subject.business_type = nil
        end

        it 'バリデーションが通ること' do
          expect(subject).to be_valid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('会社形態を入力してください')
        end
      end
    end
  end
end
