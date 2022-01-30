require 'rails_helper'

RSpec.describe 'Cars', type: :system do
  let(:user) { create(:user) }
  let(:business) { create(:business, user: user) }
  let(:car) { build(:car, business: business) }

  describe '車両情報CRUD' do
    # ログイン
    before(:each) do
      user.skip_confirmation!
      user.save!
      # 事業所登録
      business.save!
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
    end

    context '画面遷移（新規作成前）' do
      it '車両情報新規作成' do
        visit new_users_car_path

        fill_in 'car[owner_name]', with: car.owner_name
        fill_in 'car[safety_manager]', with: car.safety_manager
        fill_in 'car[vehicle_model]', with: car.vehicle_model
        fill_in 'car[vehicle_number]', with: car.vehicle_number
        fill_in 'car[vehicle_inspection_start_on]', with: car.vehicle_inspection_start_on
        fill_in 'car[vehicle_inspection_end_on]', with: car.vehicle_inspection_end_on
        fill_in 'car[liability_securities_number]', with: car.liability_securities_number
        fill_in 'car[liability_insurance_start_on]', with: car.liability_insurance_start_on
        fill_in 'car[liability_insurance_end_on]', with: car.liability_insurance_end_on
        fill_in 'car[voluntary_securities_number]', with: car.voluntary_securities_number
        fill_in 'car[voluntary_insurance_start_on]', with: car.voluntary_insurance_start_on
        fill_in 'car[voluntary_securities_number]', with: car.voluntary_insurance_end_on

        click_button '登録'
        # 車両情報詳細画面へ遷移することを期待する
        expect(page).to have_current_path users_car_path(1), ignore_query: true
        # 遷移されたページに'車両情報詳細'の文字列があることを期待する
        expect(page).to have_content '車両情報詳細'
        # 遷移されたページに'#{car.owner_name}'の文字列があることを期待する
        expect(page).to have_content car.owner_name
      end
    end

    context '画面遷移（新規作成後）' do
      it '車両情報編集' do
        # 車両情報登録
        car.save!
        visit edit_users_car_path(car)

        fill_in 'car[owner_name]', with: 'test'

        click_button '更新'

        # 車両情報詳細画面へ遷移することを期待する
        expect(page).to have_current_path users_car_path(car), ignore_query: true
        # 遷移されたページに'車両情報詳細'の文字列があることを期待する
        expect(page).to have_content '車両情報詳細'
        # 遷移されたページに'test'の文字列があることを期待する
        expect(page).to have_content 'test'
      end
    end
  end
end
