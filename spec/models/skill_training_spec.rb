require 'rails_helper'

RSpec.describe SkillTraining, type: :model do
  let(:skill_training) { create(:skill_training) }

  describe 'バリデーションのテスト' do
    context 'バリデーションを通過する場合' do
      it 'factorybotで作成したskill_trainingが有効である事' do
        expect(skill_training).to be_valid
      end
    end

    context 'バリデーションに引っかかる場合' do
      it 'name(名前)が無ければ無効となりエラーが出る事' do
        skill_training.name = ''
        skill_training.valid?
        expect(skill_training.errors[:name]).to include('を入力してください')
      end

      it 'short_name(略称)が無ければ無効となりエラーが出る事' do
        skill_training.short_name = ''
        skill_training.valid?
        expect(skill_training.errors[:short_name]).to include('を入力してください')
      end
    end
  end
end
