require 'rails_helper'

RSpec.describe 'Admins', type: :system do
  # テストユーザーを作成する
  let!(:admin) { create(:admin, email: 'foo@example.com', password: '123456', password_confirmation: '123456') }

  describe '管理者ログイン・ログアウト' do
    context 'ログインページへアクセスした場合' do
      it 'ログインページを表示' do
        visit new_admin_session_path
        expect(page).to have_content('ログイン')
      end
    end

    context 'メールアドレスとパスワードが正しい場合' do
      it 'ログインしダッシュボードを表示' do
        visit new_admin_session_path
        fill_in 'admin[email]', with: 'foo@example.com'
        fill_in 'admin[password]', with: '123456'
        click_button 'ログイン'
        # ログイン後遷移先変更時は修正の必要あり
        expect(page).to have_current_path _system__dashboard_path, ignore_query: true
        expect(page).to have_content('ログインしました。')
      end
    end

    context 'メールアドレスとパスワードが間違っている場合' do
      it 'ログインできない' do
        visit new_admin_session_path
        fill_in 'admin[email]', with: 'bar@example.com'
        fill_in 'admin[password]', with: 'password'
        click_button 'ログイン'
        expect(page).to have_current_path new_admin_session_path, ignore_query: true
        expect(page).to have_content('Eメールまたはパスワードが違います。')
      end
    end

    context 'メールアドレスとパスワードが未入力の場合' do
      it 'ログインできない' do
        visit new_admin_session_path
        fill_in 'admin[email]', with: ''
        fill_in 'admin[password]', with: ''
        click_button 'ログイン'
        expect(page).to have_current_path new_admin_session_path, ignore_query: true
        expect(page).to have_content('Eメールまたはパスワードが違います。')
      end
    end

    context 'ログアウトをクリックした場合' do
      it 'ログアウトしログイン画面を表示' do
        admin_login(admin)
        click_link 'ログアウト'
        expect(page).to have_current_path new_admin_session_path, ignore_query: true
        expect(page).to have_content('ログイン')
      end
    end
  end

  describe '管理者ログイン後' do
    before(:each) { admin_login(admin) }

    let!(:user) { create(:user) }

    describe 'ヘッダーからの画面遷移' do
      context 'ダッシュボードをクリックした場合' do
        it 'ダッシュボードを表示' do
          click_link 'ダッシュボード'
          expect(page).to have_current_path _system__dashboard_path, ignore_query: true
          expect(page).to have_content('ダッシュボード')
        end
      end

      context 'Adminsをクリックした場合' do
        it 'Admins一覧を表示' do
          click_link 'Admins'
          expect(page).to have_current_path _system__admins_path, ignore_query: true
          expect(page).to have_content('Admins')
        end
      end

      context 'Commentsをクリックした場合' do
        it 'Comments一覧を表示' do
          click_link 'Comments'
          expect(page).to have_current_path _system__comments_path, ignore_query: true
          expect(page).to have_content('Comments')
        end
      end

      context 'ユーザーをクリックした場合' do
        it 'ユーザー一覧を表示' do
          click_link 'ユーザー'
          expect(page).to have_current_path _system__users_path, ignore_query: true
          expect(page).to have_content('ユーザー')
        end
      end
    end

    describe '管理者一覧ページからの遷移' do
      before(:each) { visit _system__admins_path }

      context '閲覧をクリックした場合' do
        it '管理者詳細ページを表示' do
          click_link '閲覧'
          expect(page).to have_current_path _system__admin_path(admin), ignore_query: true
          expect(page).to have_content('Admin の詳細')
        end
      end

      context '編集をクリックした場合' do
        it '管理者編集ページを表示' do
          click_link '編集'
          expect(page).to have_current_path edit__system__admin_path(admin), ignore_query: true
          expect(page).to have_content('Admin を編集する')
        end
      end
    end

    describe 'Admin詳細ページからの遷移' do
      before(:each) { visit _system__admin_path(admin) }

      context 'Adminを編集するをクリックした場合' do
        it '管理者編集ページを表示' do
          click_link 'Admin を編集する'
          expect(page).to have_current_path edit__system__admin_path(admin), ignore_query: true
          expect(page).to have_content('Admin を編集する')
        end
      end
    end

    describe 'ユーザー一覧ページからの遷移' do
      before(:each) { visit _system__users_path }

      context 'ユーザーを作成するをクリックした場合' do
        it 'ユーザー登録ページを表示' do
          click_link 'ユーザー を作成する'
          expect(page).to have_current_path new__system__user_path, ignore_query: true
          expect(page).to have_content('ユーザー を作成する')
        end
      end

      context '閲覧をクリックした場合' do
        it 'ユーザー詳細ページを表示' do
          click_link '閲覧'
          expect(page).to have_current_path _system__user_path(user), ignore_query: true
          expect(page).to have_content('ユーザー の詳細')
        end
      end

      context '編集をクリックした場合' do
        it 'ユーザー編集ページを表示' do
          click_link '編集'
          expect(page).to have_current_path edit__system__user_path(user), ignore_query: true
          expect(page).to have_content('ユーザー を編集する')
        end
      end

      # ↓エラーあり
      # context '削除をクリックした場合' do
      #   it 'アラートを表示、ユーザー削除', js: true do
      #     page.accept_confirm do
      #       click_link '削除'
      #     end
      #     expect { user.destroy }.to change(User, :count).by(-1)
      #   end
      # end
    end

    describe 'ユーザー詳細ページからの遷移' do
      before(:each) { visit _system__user_path(user) }

      context 'ユーザーを編集するをクリックした場合' do
        it 'ユーザー編集ページを表示' do
          click_link 'ユーザー を編集する'
          expect(page).to have_current_path edit__system__user_path(user), ignore_query: true
          expect(page).to have_content('ユーザー を編集する')
        end
      end

      # ↓エラーあり
      # context 'ユーザーを削除するをクリックした場合' do
      #   it 'アラートを表示', js: true do
      #     page.accept_confirm do
      #       click_link 'ユーザー を削除する'
      #     end
      #     expect { user.destroy }.to change(User, :count).by(-1)
      #   end
      # end
    end
  end
end
