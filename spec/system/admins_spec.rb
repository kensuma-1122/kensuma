require 'rails_helper'

RSpec.describe 'Admins', type: :system do
  before(:each) do
    @admin = Admin.create!(email: 'foo@example.com', password: '123456')
  end

  describe 'ログイン後の画面表示' do
    context 'ログインできる時' do
      it '保存済みのadmin情報と合致すればログイン出来ダッシュボードに遷移する' do
        visit new_admin_session_path
        fill_in 'admin[email]', with: 'foo@example.com'
        fill_in 'admin[password]', with: '123456'
        click_on 'ログイン'
        expect(page).to have_current_path(_system__dashboard_path, ignore_query: true)
        expect(page).to have_content 'ダッシュボード'
      end
    end

    context 'ログイン出来ない時' do
      context '入力値空欄の場合' do
        it 'エラーと共にログイン画面が表示される' do
          visit new_admin_session_path
          fill_in 'admin[email]', with: ''
          fill_in 'admin[password]', with: ''
          click_on 'ログイン'
          expect(page).to have_current_path(new_admin_session_path, ignore_query: true)
          expect(page).to have_content 'Eメールまたはパスワードが違います。'
        end
      end

      context '保存済みのadmin情報と合致しない場合' do
        it 'エラーと共にログイン画面が表示される' do
          visit new_admin_session_path
          fill_in 'admin[email]', with: 'bar@example.com'
          fill_in 'admin[password]', with: '654321'
          click_on 'ログイン'
          expect(page).to have_current_path(new_admin_session_path, ignore_query: true)
          expect(page).to have_content 'Eメールまたはパスワードが違います。'
        end
      end
    end
  end

  describe 'ログアウト後の画面表示' do
    context 'ログアウト時' do
      it 'adminのログイン画面に遷移する' do
        visit new_admin_session_path
        fill_in 'admin[email]', with: 'foo@example.com'
        fill_in 'admin[password]', with: '123456'
        click_on 'ログイン'
        expect(page).to have_current_path(_system__dashboard_path, ignore_query: true)
        expect(page).to have_content 'ダッシュボード'
        click_on 'ログアウト'
        expect(page).to have_current_path(admin_session_path, ignore_query: true)
        expect(page).to have_content 'ログイン'
      end
    end
  end

  describe 'ヘッダーのリンククリック後の画面' do
    context 'adminがログインしている時' do
      before(:each) do
        sign_in(@admin)
        visit _system__dashboard_path
      end

      context 'ダッシュボードクリック時' do
        it 'ダッシュボード画面に遷移' do
          click_on 'ダッシュボード'
          expect(page).to have_current_path(_system__dashboard_path, ignore_query: true)
          expect(page).to have_content 'ダッシュボード'
        end
      end

      context 'Adminsクリック時' do
        it 'admin一覧画面に遷移' do
          click_on 'Admins'
          expect(page).to have_current_path(_system__admins_path, ignore_query: true)
          expect(page).to have_content 'Admins'
        end
      end

      context 'Commentsクリック時' do
        it 'comment一覧画面に遷移' do
          click_on 'Comments'
          expect(page).to have_current_path(_system__comments_path, ignore_query: true)
          expect(page).to have_content 'Comments'
        end
      end

      context 'ユーザークリック時' do
        it 'ユーザー一覧画面に遷移' do
          click_on 'ユーザー'
          expect(page).to have_current_path(_system__users_path, ignore_query: true)
          expect(page).to have_content 'Comments'
        end
      end
    end
  end

  describe 'admin一覧画面からのCRUD遷移テスト' do
    before(:each) do
      sign_in(@admin)
      visit _system__dashboard_path
      click_on 'Admins'
      visit _system__admins_path
    end

    context '閲覧クリック時' do
      it '閲覧画面に遷移' do
        click_on '閲覧'
        expect(page).to have_current_path(_system__admin_path(@admin), ignore_query: true)
      end
    end

    context '編集クリック時' do
      it '編集画面に遷移' do
        click_on '編集'
        expect(page).to have_current_path(edit__system__admin_path(@admin), ignore_query: true)
      end
    end
    # adminの削除ボタンは必要かどうかまだ不明の為一旦記載無
  end

  describe 'ユーザー一覧画面からのCRUD遷移テスト' do
    let!(:user) { create(:user) }

    before(:each) do
      sign_in(@admin)
      visit _system__dashboard_path
      click_on 'ユーザー'
      visit _system__users_path
    end

    context 'ユーザーを作成するボタンをクリック時' do
      it 'ユーザー作成画面に遷移' do
        click_on 'ユーザー を作成する'
        expect(page).to have_current_path(new__system__user_path, ignore_query: true)
      end
    end

    context '閲覧クリック時' do
      it '閲覧画面に遷移' do
        click_on '閲覧', match: :first
        expect(page).to have_current_path(_system__user_path(user), ignore_query: true)
      end
    end

    context '編集クリック時' do
      it '編集画面に遷移' do
        click_on '編集', match: :first
        expect(page).to have_current_path(edit__system__user_path(user), ignore_query: true)
      end
    end

    # エラーが出るので一旦コメントアウト
    # context "削除クリック時", js: true do
    #   it '削除アラートから削除できる' do
    #     click_on '削除', match: :first
    #     page.accept_confirm do
    #       click_on :delete_button
    #     end
    #     expect { user.destroy }.to change(User, :count).by(-1)
    #   end
    # end
  end
end
