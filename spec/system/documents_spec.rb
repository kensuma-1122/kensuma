require 'rails_helper'

RSpec.describe 'Documnents', type: :system do
  let(:user) { create(:user) }
  let(:business) { create(:business, user: user) }
  let(:order) { create(:order, business: business) }
  let(:request_order) { create(:request_order, business: business, order: order) }
  let(:document) { create(:document, business: business, request_order: request_order) }
  let(:cover) { create(:document, :cover, business: business, request_order: request_order) }
  let(:table) { create(:document, :table, business: business, request_order: request_order) }
  let(:doc_3rd) { create(:document, :doc_3rd, business: business, request_order: request_order) }
  let(:doc_8th) { create(:document, :doc_8th, business: business, request_order: request_order) }

  describe '書類関連' do
    before(:each) do
      user.skip_confirmation!
      user.save!
      business.save!
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'

      document_pages = 9 # 書類の種類の数
      document_pages.times do |page|
        create(:document, request_order: request_order, business: business, document_type: page)
      end
    end

    it 'ログイン後発注一覧画面へ遷移できること' do
      visit users_request_order_documents_path(request_order)
      expect(page).to have_content '書類一覧'
    end

    context '表紙' do
      subject { cover }

      it '表紙の詳細画面へ遷移できること' do
        visit users_request_order_document_path(request_order, subject)
        expect(page).to have_content '表紙'
        expect(page).to have_content 'test1'
        expect(page).to have_content '2022-01-01'
      end

      it '表紙の編集後、詳細画面へリダイレクトできること' do
        visit edit_users_request_order_document_path(request_order, subject)
        expect(page).to have_content '表紙編集'

        (all('#document_content')[0]).set('edit1')
        (all('#document_content')[1]).set('2022-12-31')
        click_button '登録'

        visit users_request_order_document_path(request_order, subject)
        expect(page).to have_content '表紙'
        expect(page).to have_content 'edit1'
        expect(page).to have_content '2022-12-31'
      end
    end

    context '目次' do
      subject { table }

      it '目次の詳細画面へ遷移できること' do
        visit users_request_order_document_path(request_order, subject)
        expect(page).to have_content '目次'
      end
    end

    context '施工体制台帳作成建設工事の通知' do
      subject { doc_3rd }

      it '施工体制台帳作成建設工事の通知の詳細画面へ遷移できること' do
        visit users_request_order_document_path(request_order, subject)
        expect(page).to have_content '全建統⼀様式第２号(施⼯体制台帳作成建設⼯事の通知)'
      end

      it '施工体制台帳作成建設工事の通知の編集後、詳細画面へリダイレクトできること' do
        visit edit_users_request_order_document_path(request_order, subject)
        expect(page).to have_content '全建統⼀様式第２号(施⼯体制台帳作成建設⼯事の通知)編集'
        click_button '登録'

        visit users_request_order_document_path(request_order, subject)
        expect(page).to have_content '全建統⼀様式第２号(施⼯体制台帳作成建設⼯事の通知)'
      end
    end

    context '作業員名簿' do
      subject { doc_8th }

      it '作業員名簿の詳細画面へ遷移できること' do
        visit users_request_order_document_path(request_order, subject)
        expect(page).to have_content '全建統⼀様式第５号改(作業員名簿)'
      end

      it '作業員名簿の編集画面へ遷移できること' do
        visit edit_users_request_order_document_path(request_order, subject)
        expect(page).to have_content '全建統⼀様式第５号改(作業員名簿)編集'
      end
    end
  end
end
