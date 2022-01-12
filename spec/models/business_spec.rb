# frozen_string_literal: true

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
      Business.skip_callback(:validation, :before, :set_uuid)
      
      context '存在しない場合' do
        before :each do
          subject.uuid = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('事業所IDを入力してください')
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
          expect(subject.errors.full_messages).to include('事業所名を入力してください')
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
          expect(subject.errors.full_messages).to include('事業所名(カナ)を入力してください')
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
          expect(subject.errors.full_messages).to include('支店名、営業所名を入力してください')
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
          expect(subject.errors.full_messages).to include('代表者名を入力してください')
        end
      end
    end

    describe '#email' do
      context '存在しない場合' do
        before :each do
          subject.email = nil
        end

        it 'バリデーションが落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('事業所メールアドレスを入力してください')
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
          expect(subject.errors.full_messages).to include('事業所メールアドレスはすでに存在します')
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
            expect(subject.errors.full_messages).to include('事業所メールアドレスは不正な値です')
          end
        end
      end
    end

    describe '#address' do
      context '存在しない場合' do
        before :each do
          subject.address = nil
        end

        it 'バリデーションが落ちること' do
          expect(subject).to be_invalid
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

        it 'バリデーションが落ちること' do
          expect(subject).to be_invalid
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

        it 'バリデーションが落ちること' do
          expect(subject).to be_invalid
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

        it 'バリデーションが落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('会社形態を入力してください')
        end
      end
    end
  end
end
