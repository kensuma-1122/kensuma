require 'rails_helper'

RSpec.describe RequestOrder, type: :model do
  let :business do
    create(:business)
  end

  let :order do
    create(:order)
  end

  let :request_order do
    create(:request_order, business: business, order: order)
  end

  describe 'アソシエーションについて' do
    context '紐つく事業所がある場合' do
      subject do
        request_order.business
      end

      it '紐つく事業所を返すこと' do
        expect(subject).to eq(business)
      end
    end

    context '紐つく発注がある場合' do
      subject do
        request_order.order
      end

      it '紐つく発注を返すこと' do
        expect(subject).to eq(order)
      end
    end
  end
end
