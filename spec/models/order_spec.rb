require 'rails_helper'

RSpec.describe Order, type: :model do
  let :order do
    build(:order)
  end

  describe 'バリデーションについて' do
    subject do
      order
    end

    it 'バリデーションが通ること' do
      expect(subject).to be_valid
    end

    describe '#status' do
      context '存在しない場合' do
        before :each do
          subject.status = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('状態を入力してください')
        end
      end
    end

    describe '#site_name' do
      context '存在しない場合' do
        before :each do
          subject.site_name = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('現場名を入力してください')
        end
      end
    end

    describe '#order_post_code' do
      context '存在しない場合' do
        before :each do
          subject.order_post_code = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('発注者郵便番号を入力してください')
        end
      end

      %i[
        01234567
        0123
        012345
        012-3456
      ].each do |order_post_code|
        context '不正なorder_post_codeの場合' do
          before :each do
            subject.order_post_code = order_post_code
          end

          it 'バリデーションに落ちること' do
            expect(subject).to be_invalid
          end

          it 'バリデーションのエラーが正しいこと' do
            subject.valid?
            expect(subject.errors.full_messages).to include('発注者郵便番号は不正な値です')
          end
        end
      end
    end

    describe '#order_address' do
      context '存在しない場合' do
        before :each do
          subject.order_address = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('発注者住所を入力してください')
        end
      end
    end
  end

  describe '#site_uu_idのbefore_createについて' do
    context 'site_uu_idが保存されていれば' do
      before(:each) do
        order.save!
      end

      it 'order.site_uu_idがtrueである事' do
        expect(order.site_uu_id).to be_truthy
      end
    end

    context 'site_uu_idが保存されていなければ' do
      it 'order.site_uu_idがtrueである事' do
        expect(order.site_uu_id).to be_falsey
      end
    end
  end

  describe '事業所とのアソシエーションについて' do
    let :business do
      create(:business)
    end

    let :orders do
      create_list(:order, 2, business: business)
    end

    context '事業所に紐づく発注がある場合' do
      subject do
        business.orders
      end

      it '紐つく発注を返すこと' do
        expect(subject).to eq(orders)
      end
    end
  end
end
