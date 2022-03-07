require 'rails_helper'

RSpec.describe 'SubRequestOrders', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/sub_request_orders/index'
      expect(response).to have_http_status(:success)
    end
  end
end
