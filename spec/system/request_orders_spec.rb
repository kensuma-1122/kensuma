require 'rails_helper'

RSpec.describe 'RequestOrders', type: :system do
  let(:user) { create(:user) }
  let(:business) { create(:business, user: user) }
  let(:order) { create(:order, business: business) }
  let(:request_order) { create(:request_order, business: business, order: order) }

  describe '発注依頼関連' do
    before(:each) do
      user.skip_confirmation!
      user.save!
      business.save!
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
    end

    context 'ログイン後' do
      it '発注一覧画面へ遷移できること' do
        visit users_request_orders_path
        expect(page).to have_content '発注依頼一覧'
      end

      it '詳細画面へ遷移すること' do
        visit users_request_order_path(request_order)
        expect(page).to have_content '発注依頼詳細'
        expect(page).to have_content request_order.status_i18n
        expect(page).to have_content request_order.business.name
      end
    end
  end
end
