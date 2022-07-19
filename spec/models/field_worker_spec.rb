require 'rails_helper'

RSpec.describe FieldWorker, type: :model do
  let(:order_field_worker) { build(:order_field_worker) }

  describe 'order側バリデーションについて' do
    subject { order_field_worker } 

    it 'バリデーションが通ること' do
      expect(subject).to be_valid
    end

    describe '#admission_worker_name' do
      context "存在しない場合" do
        before(:each) { subject.admission_worker_name = nil }
      end

      # it 'バリデーションに落ちること' do
      #   expect(subject).to be_valid
      # end
    end
  end
end
