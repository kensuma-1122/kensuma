require 'rails_helper'

RSpec.describe 'Admins', type: :system do
  before do
    @admin = Admin.create!(email: 'foo@example.com', password: '123456')
  end

  describe "ログイン" do
    context "ログインできる時" do
      it '保存済みのユーザー情報と合致すればログイン出来ダッシュボードに遷移する' do
        visit new_admin_session_path
        fill_in 'admin[email]', with: 'foo@example.com'
        fill_in 'admin[password]', with: '123456'
        click_on 'ログイン'
        expect(current_path).to eq(_system__dashboard_path)
        expect(page).to have_content 'ダッシュボード'
      end  
    end

    context "ログイン出来ない時" do
      context "入力値空欄の場合" do
        it 'エラーと共にログイン画面が表示される' do
          visit new_admin_session_path
          fill_in 'admin[email]', with: ''
          fill_in 'admin[password]', with: ''
          click_on 'ログイン'
          expect(current_path).to eq(new_admin_session_path)
          expect(page).to have_content 'Eメールまたはパスワードが違います。'
        end
      end

      context "保存済みのユーザー情報と合致しない場合" do
        it 'エラーと共にログイン画面が表示される' do
          visit new_admin_session_path
          fill_in 'admin[email]', with: 'bar@example.com'
          fill_in 'admin[password]', with: '654321'
          click_on 'ログイン'
          expect(current_path).to eq(new_admin_session_path)
          expect(page).to have_content 'Eメールまたはパスワードが違います。'
        end
      end
    end
  end

  describe "ログアウト" do
    context "ログアウトした時" do
      it 'adminのログイン画面に遷移する' do
        visit new_admin_session_path
        fill_in 'admin[email]', with: 'foo@example.com'
        fill_in 'admin[password]', with: '123456'
        click_on 'ログイン'
        expect(current_path).to eq(_system__dashboard_path)
        expect(page).to have_content 'ダッシュボード'
        click_on 'ログアウト'
        expect(current_path).to eq(admin_session_path)
        expect(page).to have_content 'ログイン'
      end
    end
  end

  describe ""

end