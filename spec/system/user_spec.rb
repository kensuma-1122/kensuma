require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let!(:user) { create(:user) }

  describe 'ユーザーログイン後' do
    context '事業所が作成された場合' do
      it 'ダッシュボードを表示' do
        user_login(user)
        # expect(page).to have_current_path new_users_business_path, ignore_query: true
        # expect(page).to have_content('事業所登録')
        # click_button '登録'

        # expect(page).to have_current_path users_dash_boards_path, ignore_query: true
        # expect(page).to have_content('DashBoard')
        # expect(page).to have_content('発注')
        # expect(page).to have_content('作業員')
        # expect(page).to have_content('事業所')
        # expect(page).to have_content('ユーザー')
      end
    end
  end
end
