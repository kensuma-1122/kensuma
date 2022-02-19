require 'rails_helper'

RSpec.describe WorkerLicense, type: :model do
  let(:worker) { create(:worker) }
  let(:license) { create(:license) }
  let(:worker_license) { create(:worker_license, worker: worker, license: license) }

  describe 'バリデーションのテスト' do
    context 'バリデーションを通過する場合' do
      it 'worker_idとlicense_idがある場合、有効である事' do
        expect(worker_license).to be_valid
      end
    end

    context 'バリデーションに引っかかる場合' do
      it "worker_idがない場合、無効であること" do
        worker_license.worker_id = ''
        expect(worker_license).to be_invalid
      end

      it "license_idがない場合、無効であること" do
        worker_license.license_id = ''
        expect(worker_license).to be_invalid
      end

      it 'got_on(取得年月日)が無ければ無効となりエラーが出る事' do
        worker_license.got_on = ''
        worker_license.valid?
        expect(worker_license.errors[:got_on]).to include('を入力してください')
      end
    end
  end
end
