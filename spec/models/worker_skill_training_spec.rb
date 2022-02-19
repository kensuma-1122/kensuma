require 'rails_helper'

RSpec.describe WorkerSkillTraining, type: :model do
  let(:worker) { create(:worker) }
  let(:skill_training) { create(:skill_training) }
  let(:worker_skill_training) { create(:worker_skill_training, worker: worker, skill_training: skill_training) }

  describe 'バリデーションのテスト' do
    context 'バリデーションを通過する場合' do
      it 'worker_idとskill_training_idがある場合、有効である事' do
        expect(worker_skill_training).to be_valid
      end
    end

    context 'バリデーションに引っかかる場合' do
      it 'worker_idがない場合、無効であること' do
        worker_skill_training.worker_id = ''
        expect(worker_skill_training).to be_invalid
      end

      it 'skill_training_idがない場合、無効であること' do
        worker_skill_training.skill_training_id = ''
        expect(worker_skill_training).to be_invalid
      end

      it 'got_on(取得年月日)が無ければ無効となりエラーが出る事' do
        worker_skill_training.got_on = ''
        worker_skill_training.valid?
        expect(worker_skill_training.errors[:got_on]).to include('を入力してください')
      end
    end
  end
end
