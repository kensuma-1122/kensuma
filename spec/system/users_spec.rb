require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let!(:user_a) { create(:user, name: 'ユーザーA', email: 'aaa-user@example.com', password: '123456', password_confirmation: '123456') }
  let!(:user_b) { create(:user, name: 'ユーザーB', email: 'bbb-user@example.com', password: '123456', password_confirmation: '123456') }
  let!(:business_a) { create(:business, user: user_a) }

  let(:user) { create(:user) }
  let(:business) { create(:business, user: user) }
  let(:general_user) { create(:user, admin_user_id: user.id) }

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
          expect(page).to have_content('メールアドレスまたはパスワードが違います。')
        end
      end

      context 'メールアドレスとパスワードが未入力の場合' do
        it 'ログインできない' do
          visit new_user_session_path
          fill_in 'user[email]', with: ''
          fill_in 'user[password]', with: ''
          click_button 'ログイン'
          expect(page).to have_current_path new_user_session_path, ignore_query: true
          expect(page).to have_content('メールアドレスまたはパスワードが違います。')
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

  describe 'その他のユーザー関連' do
    before(:each) do
      user.skip_confirmation!
      user.save!
      business.save!
      general_user.save!

      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
    end

    it 'ユーザー一覧画面へ遷移できること' do
      visit users_general_users_path
      expect(page).to have_content 'ユーザー一覧'
    end

    context 'ユーザー一覧画面から' do
      before(:each) do
        visit users_general_users_path
      end

      it 'ユーザー登録画面へ遷移できること' do
        click_link '新規登録'
        visit new_users_general_user_path
        expect(page).to have_content 'ユーザー登録'
      end

      it '登録済ユーザー詳細画面へ遷移できること' do
        click_on '詳細'
        visit users_general_user_path(general_user)
        expect(page).to have_content 'ユーザー詳細'
      end

      it '登録済ユーザー編集画面へ遷移できること' do
        click_on '編集'
        visit edit_users_general_user_path(general_user)
        expect(page).to have_content 'ユーザー編集'
      end
    end

    context 'ユーザー登録' do
      it '新規登録したあと新規登録画面から詳細画面へ遷移すること' do
        visit new_users_general_user_path

        fill_in 'user[name]', with: general_user.name
        fill_in 'user[email]', with: general_user.email
        fill_in 'user[age]', with: general_user.age
        fill_in 'user[password]', with: general_user.email
        fill_in 'user[password_confirmation]', with: general_user.email
        click_button '登録'

        visit users_general_user_path(general_user)
        expect(page).to have_content 'ユーザー詳細'
        expect(page).to have_content user.name
      end
    end

    context 'ユーザー編集' do
      it '更新したあと編集画面から詳細画面へ遷移すること' do
        visit edit_users_general_user_path(general_user)

        fill_in 'user[name]', with: 'edit name'
        fill_in 'user[email]', with: general_user.email
        fill_in 'user[age]', with: general_user.age
        fill_in 'user[password]', with: general_user.email
        fill_in 'user[password_confirmation]', with: general_user.email
        click_button '更新'

        visit users_general_user_path(general_user)
        expect(page).to have_content 'ユーザー詳細'
        expect(page).to have_content 'edit name'
      end
    end

    context 'ユーザー削除' do
      it '一覧画面から削除したあと同画面にリダイレクトすること', js: true do
        visit users_general_users_path
        click_on '削除'

        expect {
          expect(page.accept_confirm).to eq '本当に削除しますか？'
          expect(page).to have_content "#{general_user.name}を削除しました"
        }.to change(User, :count).by(-1)

        visit users_general_users_path
        expect(page).to have_content 'ユーザー一覧'
      end

      it '詳細画面から削除したあと一覧画面に遷移すること', js: true do
        visit users_general_user_path(general_user)
        click_on '削除'

        expect {
          expect(page.accept_confirm).to eq '本当に削除しますか？'
          expect(page).to have_content "#{general_user.name}を削除しました"
        }.to change(User, :count).by(-1)

        visit users_general_users_path
        expect(page).to have_content 'ユーザー一覧'
      end
    end
  end
end
