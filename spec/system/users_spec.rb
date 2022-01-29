require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let!(:user_a) { create(:user, name: 'ユーザーA', email: 'aaa-user@example.com', password: '123456', password_confirmation: '123456') }
  let!(:user_b) { create(:user, name: 'ユーザーB', email: 'bbb-user@example.com', password: '123456', password_confirmation: '123456') }
  let!(:business_a) { create(:business, user: user_a) }

  before(:each) do
    user_a.skip_confirmation!
    user_a.save!
    user_b.skip_confirmation!
    user_b.save!
  end

  describe 'ユーザーログイン時の画面表示' do
    context 'ログインページへアクセスした場合' do
      it 'ログイン画面を表示' do
        visit new_user_session_path
        expect(page).to have_content('ログイン')
        expect(page).to have_content('パスワードを忘れましたか？')
        expect(page).to have_content('認証メールの再送信')
      end
    end

    context '異常系' do
      context 'メールアドレスとパスワードが登録済み情報と合致しない場合' do
        it 'ログインできない' do
          visit new_user_session_path
          fill_in 'user[email]', with: 'ccc-user@example.com'
          fill_in 'user[password]', with: '78910'
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

    context '正常系' do
      context '事業所作成済ユーザー（ユーザーA）ログインの場合' do
        it 'ログイン後ダッシュボードを表示' do
          visit new_user_session_path
          fill_in 'user[email]', with: 'aaa-user@example.com'
          fill_in 'user[password]', with: '123456'
          click_button 'ログイン'
          expect(page).to have_current_path users_dash_boards_path, ignore_query: true
          expect(page).to have_content('ログインしました。')
        end
      end

      context '事業所未作成ユーザー（ユーザーB）ログインの場合' do
        it 'ログイン後事業所登録画面を表示' do
          visit new_user_session_path
          fill_in 'user[email]', with: 'bbb-user@example.com'
          fill_in 'user[password]', with: '123456'
          click_button 'ログイン'
          expect(page).to have_current_path new_users_business_path, ignore_query: true
          expect(page).to have_content('ログインしました。')
          expect(page).to have_content('事業所登録')
        end
      end
    end
  end
end
