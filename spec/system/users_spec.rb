require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user) { create(:user) }
  let(:business) { create(:business, user: user) }
  let(:general_user) { create(:user, admin_user_id: user.id) }

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
      it '削除したあと一覧画面から同画面にリダイレクトすること', js: true do
        visit users_general_users_path
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
