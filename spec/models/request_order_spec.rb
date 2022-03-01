require 'rails_helper'

RSpec.describe RequestOrder, type: :model do
  let(:business) { create(:business) }
  let(:order) { create(:order) }
  let(:request_order) { create(:request_order, order: order, business: business) }

  describe 'バリデーションについて' do
    subject { request_order }

    it 'バリデーションが通ること' do
      expect(subject).to be_valid
    end

    describe '#status' do
      context '存在しない場合' do
        before(:each) { subject.status = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
          subject.valid?
          expect(subject.errors.full_messages).to include('ステータスを入力してください')
        end
      end
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
      context '存在しない(nil)場合' do
        before(:each) { subject.business_id = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
          subject.valid?
          expect(subject.errors.full_messages).to include('Businessを入力してください')
        end
      end

      context '対象となるBusinessが存在しない場合' do
        before(:each) { subject.business_id = subject.business_id + 1 }

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

    context '紐つく事業所がある場合' do
      subject { request_order.business }

      it '紐つく事業所を返すこと' do
        expect(subject).to eq(business)
      end
    end
  end
end
