require 'rails_helper'

RSpec.describe 'Businesses', type: :system do

  before do
    @user = FactoryBot.create(:user)
  end

  context "ログインできる時" do
    it '...' do
      @user.skip_confirmation!
      @user.save!
      sign_in @user
      visit new_users_business_path
      expect(page).to have_content '事業所作成画面'
    end  
  end

  # context 'ユーザーがログインしているとき' do
  #   it 'qq' do
  #     visit new_user_session_path
  #     fill_in 'user[email]', with: 'user@example.com'
  #     fill_in 'user[password]', with: 'password'
  #     # click_button 'ログイン'
  #     visit '/users/business/new'
  #     expect(page).to have_content '事業所作成画面'
  #   end

    # it 'ログイン後のフラッシュメッセージが表示される' do
    #   visit '/users/business/new'
    #   expect(page).to have_content '事業所作成画面'
    # end
  # end

  

  # describe '...' do
  #   it '作成画面が表示されること' do
  #     @user = User.create(email: 'sample@email.com', password: 'pass')
  #     visit new_user_session_path
  #     fill_in 'user_email', with: @user.email
  #     fill_in 'user_password', with: @user.password
  #     click_button 'ログイン'
  #     visit '/users/business/new'
  #     expect(page).to have_content('事業所作成画面')
  #   end
  # end
end
