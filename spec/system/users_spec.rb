require 'rails_helper'

RSpec.describe 'Users', type: :system do
  # 事業所を持つテストユーザー
  let!(:user1) { create(:user, name: 'user1', email: 'user1@example.com', password: '123456') }
  # 事業所を持たないテストユーザー
  let!(:user2) { create(:user, name: 'user2', email: 'user2@example.com', password: '123456') }
  let!(:business) { create(:business, user: user1) }

  describe 'ユーザーログイン・ログアウト' do
    context 'ログインページへアクセスした場合' do
      it 'ログインページを表示' do
        visit new_user_session_path
        expect(page).to have_current_path new_user_session_path, ignore_query: true
        expect(page).to have_content('ログイン')
        expect(page).to have_content('ログインを記憶する')
      end
    end

    context '事業所作成済み且つメールアドレスとパスワードが正しい場合' do
      it 'ログインしダッシュボードを表示' do
        visit new_user_session_path
        fill_in 'user[email]', with: 'user1@example.com'
        fill_in 'user[password]', with: '123456'
        click_button 'ログイン'
        expect(page).to have_current_path users_dash_boards_path, ignore_query: true
        expect(page).to have_content('DashBoard')
        expect(page).to have_content('発注')
        expect(page).to have_content('作業員')
        expect(page).to have_content('事業所')
        expect(page).to have_content('ユーザー')
      end
    end

    context '事業所未作成且つメールアドレスとパスワードが正しい場合' do
      it 'ログインし事業所作成画面を表示、事業所作成後はダッシュボードを表示' do
        visit new_user_session_path
        fill_in 'user[email]', with: 'user2@example.com'
        fill_in 'user[password]', with: '123456'
        click_button 'ログイン'
        expect(page).to have_current_path new_users_business_path, ignore_query: true
        expect(page).to have_content('事業所登録')
        click_on '登録'
        expect(page).to have_current_path users_dash_boards_path, ignore_query: true
        expect(page).to have_content('DashBoard')
        expect(page).to have_content('発注')
        expect(page).to have_content('作業員')
        expect(page).to have_content('事業所')
        expect(page).to have_content('ユーザー')
      end
    end

    context 'メールアドレスとパスワードが間違っている場合' do
      it 'ログインできない' do
        visit new_user_session_path
        fill_in 'user[email]', with: 'bar@example.com'
        fill_in 'user[password]', with: 'password'
        click_button 'ログイン'
        expect(page).to have_current_path new_user_session_path, ignore_query: true
        expect(page).to have_content('Eメールまたはパスワードが違います。')
      end
    end

    context 'メールアドレスとパスワードが未入力の場合' do
      it 'ログインできない' do
        visit new_user_session_path
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'ログイン'
        expect(page).to have_current_path new_user_session_path, ignore_query: true
        expect(page).to have_content('Eメールまたはパスワードが違います。')
      end
    end
  end
end
