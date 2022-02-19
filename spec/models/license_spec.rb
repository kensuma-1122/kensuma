require 'rails_helper'

RSpec.describe License, type: :model do
  let(:license) { create(:license) }

  describe 'バリデーションのテスト' do
    context 'バリデーションを通過する場合' do
      it 'factorybotで作成したlicenseが有効である事' do
        expect(license).to be_valid
      end
    end

    context 'バリデーションに引っかかる場合' do
      it 'name(名前)が無ければ無効となりエラーが出る事' do
        license.name = ''
        license.valid?
        expect(license.errors[:name]).to include('を入力してください')
      end

      it 'type(種別)が無ければ無効となりエラーが出る事' do
        license.type = ''
        license.valid?
        expect(license.errors[:type]).to include('を入力してください')
      end
    end
  end
end
