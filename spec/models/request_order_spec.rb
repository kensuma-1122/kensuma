require 'rails_helper'

RSpec.describe RequestOrder, type: :model do
  # let(:business) { create(:business) }
  let(:order) { create(:order) }
  let(:request_order) { create(:request_order, order: order) }

  describe 'バリデーションについて' do
    subject { request_order }

    it 'バリデーションが通ること' do
      expect(subject).to be_valid
    end

    describe '#request_order' do
      context '存在しない場合' do
        before(:each) { subject.status = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
          subject.valid?
          expect(subject.errors.full_messages).to include('ステータスを入力してください')
        end
      end
    end

    describe '#business_id' do
      context '存在しない場合' do
        before(:each) { subject.business_id = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
          subject.valid?
          expect(subject.errors.full_messages).to include('Businessを入力してください')
        end
      end
    end
  end

  describe 'アソシエーションについて' do
    context '紐つく発注がある場合' do
      subject { request_order.order }

      it '紐つく発注を返すこと' do
        expect(subject).to eq(order)
      end
    end
  end
end
