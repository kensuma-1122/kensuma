require 'rails_helper'

RSpec.describe License, type: :model do
  let(:license) { create(:license) }

  describe 'バリデーションについて' do
    subject do
      license
    end

    it 'バリデーションが通ること' do
      expect(subject).to be_valid
    end

    describe '#name' do
      context '存在しない場合' do
        before :each do
          subject.name = ''
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('ライセンス名を入力してください')
        end
      end
    end

    describe '#license_type' do
      context '存在しない場合' do
        before :each do
          subject.license_type = ''
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('種別を入力してください')
        end
      end
    end
  end
end
