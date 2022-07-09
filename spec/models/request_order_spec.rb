require 'rails_helper'

RSpec.describe RequestOrder, type: :model do
  let(:business) { create(:business) }
  let(:order) { create(:order) }
  let(:request_order) { create(:request_order, business: business, order: order) }

  describe 'アソシエーションについて' do
    context '紐つく事業所がある場合' do
      subject { request_order.business }

      it '紐つく事業所を返すこと' do
        expect(subject).to eq(business)
      end
    end

    context '紐つく発注がある場合' do
      subject { request_order.order }

      it '紐つく発注を返すこと' do
        expect(subject).to eq(order)
      end
    end
  end
end
