require 'rails_helper'

RSpec.describe "Businesses", type: :system do
  let(:user) { FactoryBot.create(:user) }

  # before do
  #   visit new_user_session_path
  #   fill_in "user_email", with: user.email
  #   fill_in "user_password", with: user.password
  #   click_button 'ログイン'
  # end

  it '作成画面が表示されること' do
    visit new_user_session_path
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    click_button 'ログイン'
    visit '/users/dash_boards'
    expect(page).to have_content('事業所作成画面')
  end
end
