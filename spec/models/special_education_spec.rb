require 'rails_helper'

RSpec.describe SpecialEducation, type: :model do
  let(:special_education) { create(:special_education) }

  describe 'バリデーションのテスト' do
    context 'バリデーションを通過する場合' do
      it 'factorybotで作成したspecial_educationが有効である事' do
        expect(special_education).to be_valid
      end
    end

    context 'バリデーションに引っかかる場合' do
      it 'name(名前)が無ければ無効となりエラーが出る事' do
        special_education.name = ''
        special_education.valid?
        expect(special_education.errors[:name]).to include('を入力してください')
      end
    end
  end
end
