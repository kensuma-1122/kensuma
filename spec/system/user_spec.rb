require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let!(:user) { create(:user) }

  describe 'ユーザーログイン' do
    context 'メールアドレスとパスワードが登録済み情報と合致する場合' do
      it 'ログインしダッシュボードを表示' do
        login(admin)
        # ログイン後遷移先変更時に修正の必要あり
        expect(page).to have_current_path _system__dashboard_path, ignore_query: true
        expect(page).to have_content('ログインしました。')
      end
    end
  end
end
