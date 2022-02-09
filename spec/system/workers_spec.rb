require 'rails_helper'

RSpec.describe 'Workers', type: :system do
  let!(:user) { create(:user) }
  let!(:business) { create(:business, user: user) }
  let!(:worker) { create(:worker, business: business) }

  describe '作業員CRUD' do
    before(:each) do
      user.skip_confirmation!
      user.save!
      business.save!
      sign_in(user)
      visit users_dash_boards_path
    end

    describe '作業員作成' do
      context 'フォームの入力値が正常である場合' do
        it '登録処理後、作業員詳細ページへ遷移' do
          visit new_users_worker_path

          fill_in 'worker[name]', with: 'TestWorker'
          fill_in 'worker[name_kana]', with: 'テストワーカー'
          fill_in 'worker[country]', with: '日本'
          fill_in 'worker[my_address]', with: '東京都テスト区1-1-1'
          fill_in 'worker[my_phone_number]', with: '09012345678'
          fill_in 'worker[family_address]', with: '東京都テスト区1-1-1'
          fill_in 'worker[family_phone_number]', with: '08087654321'
          fill_in 'worker[birth_day_on]', with: '2022-01-28'
          select 'A型', from: '血液型(ABO)'
          select '＋', from: '血液型(Rh)'
          # 職種は仮↓
          select 'Job1', from: '職種'
          fill_in 'worker[hiring_on]', with: '2022-01-28'
          fill_in 'worker[experience_term_before_hiring]', with: 1
          fill_in 'worker[blank_term]', with: 1
          click_on '登録'

          expect(page).to have_content '作業員情報を登録しました'
          expect(page).to have_content '作業員詳細'
        end
      end

      context 'フォームの入力値が異常である場合' do
        it '登録処理に失敗し、作成ページが再度表示' do
          visit new_users_worker_path

          fill_in 'worker[name]', with: ''
          fill_in 'worker[name_kana]', with: ''
          fill_in 'worker[country]', with: ''
          fill_in 'worker[my_address]', with: ''
          fill_in 'worker[my_phone_number]', with: ''
          fill_in 'worker[family_address]', with: ''
          fill_in 'worker[family_phone_number]', with: ''
          fill_in 'worker[birth_day_on]', with: ''
          select 'A型', from: '血液型(ABO)'
          select '＋', from: '血液型(Rh)'
          # 職種は仮↓
          select 'Job1', from: '職種'
          fill_in 'worker[hiring_on]', with: ''
          fill_in 'worker[experience_term_before_hiring]', with: 1
          fill_in 'worker[blank_term]', with: 1
          click_on '登録'

          expect(page).to have_content '作業員登録'
          expect(page).to have_content '入力エラー'
        end
      end
    end

    describe '作業員参照' do
      context '作業員一覧ページへ遷移した場合' do
        it '作業員の一覧が表示されること' do
          visit users_workers_path
          expect(page).to have_content '作業員一覧'
          expect(page).to have_content '作業員作成'
          expect(page).to have_content 'ダッシュボードへ'
        end
      end

      context '作業員詳細ページへ遷移した場合' do
        it '作業員の詳細が表示されること' do
          visit users_worker_path(worker)
          expect(page).to have_content '作業員詳細'
          expect(page).to have_content '国籍'
          expect(page).to have_content '作業員一覧へ'
        end
      end
    end

    describe '作業員編集' do
      context 'フォームの入力値が正常である場合' do
        it '更新処理後、作業員詳細ページへ遷移' do
          visit edit_users_worker_path(worker)

          fill_in 'worker[name]', with: 'TestWorker'
          fill_in 'worker[name_kana]', with: 'テストワーカー'
          fill_in 'worker[country]', with: '日本'
          fill_in 'worker[my_address]', with: '東京都テスト区1-1-1'
          fill_in 'worker[my_phone_number]', with: '09012345678'
          fill_in 'worker[family_address]', with: '東京都テスト区1-1-1'
          fill_in 'worker[family_phone_number]', with: '08087654321'
          fill_in 'worker[birth_day_on]', with: '2022-01-28'
          select 'A型', from: '血液型(ABO)'
          select '＋', from: '血液型(Rh)'
          # 職種は仮↓
          select 'Job1', from: '職種'
          fill_in 'worker[hiring_on]', with: '2022-01-28'
          fill_in 'worker[experience_term_before_hiring]', with: 1
          fill_in 'worker[blank_term]', with: 1
          click_on '更新'

          expect(page).to have_current_path users_worker_path(worker), ignore_query: true
          expect(page).to have_content '作業員詳細'
          expect(page).to have_content '作業員情報を更新しました'
        end
      end

      context 'フォームの入力値が異常である場合' do
        it '更新処理に失敗し、編集ページが再度表示' do
          visit edit_users_worker_path(worker)

          fill_in 'worker[name]', with: ''
          fill_in 'worker[name_kana]', with: ''
          fill_in 'worker[country]', with: ''
          fill_in 'worker[my_address]', with: ''
          fill_in 'worker[my_phone_number]', with: ''
          fill_in 'worker[family_address]', with: ''
          fill_in 'worker[family_phone_number]', with: ''
          fill_in 'worker[birth_day_on]', with: ''
          select 'A型', from: '血液型(ABO)'
          select '＋', from: '血液型(Rh)'
          # 職種は仮↓
          select 'Job1', from: '職種'
          fill_in 'worker[hiring_on]', with: ''
          fill_in 'worker[experience_term_before_hiring]', with: 1
          fill_in 'worker[blank_term]', with: 1
          click_on '更新'

          expect(page).to have_content '作業員編集'
          expect(page).to have_content '入力エラー'
        end
      end
    end

    describe '作業員削除' do
      context '作業員一覧の削除をクリックした場合' do
        it 'アラートから作業員を削除できる', js: true do
          visit users_workers_path

          click_on '削除'
          expect {
            page.accept_confirm
            expect(page).to have_content "#{worker.name}の情報を削除しました"
          }.to change(Worker, :count).by(-1)
        end
      end

      context '作業員詳細の削除をクリックした場合' do
        it 'アラートから作業員を削除できる', js: true do
          visit users_worker_path(worker)

          click_on '削除'
          expect {
            page.accept_confirm
            expect(page).to have_content "#{worker.name}の情報を削除しました"
          }.to change(Worker, :count).by(-1)
        end
      end
    end
  end
end
