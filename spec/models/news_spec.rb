require 'rails_helper'

RSpec.describe News, type: :model do
  let :news do
    build(:news)
  end

  describe 'Newsのバリデーションについて' do
    subject do
      news
    end

    it 'バリデーションが通ること' do
      expect(subject).to be_valid
    end

    describe '#title' do
      context '存在しない場合' do
        before :each do
          subject.title = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('Titleを入力してください')
        end
      end
    end

    describe '#status' do
      context '存在しない場合' do
        before :each do
          subject.status = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('Statusを入力してください')
        end
      end
    end
  end
end
