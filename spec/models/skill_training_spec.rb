require 'rails_helper'

RSpec.describe SkillTraining, type: :model do
  let(:skill_training) { create(:skill_training) }

  describe 'バリデーションについて' do
    subject do
      skill_training
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

    describe '#short_name' do
      context '存在しない場合' do
        before :each do
          subject.short_name = ''
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('略称を入力してください')
        end
      end
    end
  end
end
