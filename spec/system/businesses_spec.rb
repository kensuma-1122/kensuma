require 'rails_helper'

RSpec.describe 'Businesses', type: :system do
  let :user do
    create(:user)
  end

  let :business do
    create(:business)
  end

  describe '事業所作成画面表示機能' do
    subject do
      business
    end

    context 'ユーザーがログインした時' do
      it '紐づくbusinessモデルがない時、事業所作成画面が表示される' do
        user.skip_confirmation!
        user.save!
        visit new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'

        visit new_users_business_path
        expect(page).to have_content '事業所作成画面'
      end

      it '紐づくbusinessモデルがある時、ダッシュボードが表示される' do
        user.skip_confirmation!
        user.save!
        business.user_id = user.id
        visit new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'

        visit users_dash_boards_path
        expect(page).to have_content 'DashBoard'
      end
    end
  end
end
