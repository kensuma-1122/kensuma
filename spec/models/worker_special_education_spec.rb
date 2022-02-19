require 'rails_helper'

RSpec.describe WorkerSpecialEducation, type: :model do
  let(:worker) { create(:worker) }
  let(:special_education) { create(:special_education) }
  let(:worker_special_education) { create(:worker_special_education, worker: worker, special_education: special_education) }

  describe 'バリデーションのテスト' do
    context 'バリデーションを通過する場合' do
      it 'worker_idとspecial_education_idがある場合、有効である事' do
        expect(worker_special_education).to be_valid
      end
    end

    context 'バリデーションに引っかかる場合' do
      it 'worker_idがない場合、無効であること' do
        worker_special_education.worker_id = ''
        expect(worker_special_education).to be_invalid
      end

      it 'special_education_idがない場合、無効であること' do
        worker_special_education.special_education_id = ''
        expect(worker_special_education).to be_invalid
      end

      it 'got_on(取得年月日)が無ければ無効となりエラーが出る事' do
        worker_special_education.got_on = ''
        worker_special_education.valid?
        expect(worker_special_education.errors[:got_on]).to include('を入力してください')
      end
    end
  end
end
