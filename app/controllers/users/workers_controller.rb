module Users
  class WorkersController < Users::Base
    before_action :set_worker, except: %i[index new create update_images update_license_images update_skill_training_images update_special_education_images]

    def index
      @workers = current_business.workers
    end

    def new
      @worker = current_business.workers.new(
        # テスト用デフォルト値 ==========================
        name:                          'サンプル作業員',
        name_kana:                     'サンプルサギョウイン',
        country:                       '日本',
        my_address:                    '東京都港区1-1',
        my_phone_number:               '01234567898',
        family_address:                '埼玉県三郷市1-1',
        family_phone_number:           '09876543210',
        birth_day_on:                  '2000-01-28',
        abo_blood_type:                0,
        rh_blood_type:                 0,
        job_type:                      0,
        hiring_on:                     '2022-01-28',
        experience_term_before_hiring: 10,
        blank_term:                    3,
        carrier_up_id:                 '1'
        # ============================================
      )
      @worker.worker_licenses.build
      @worker.worker_skill_trainings.build
      @worker.worker_special_educations.build
    end

    def create
      @worker = current_business.workers.build(worker_params)
      if @worker.save
        flash[:success] = '作業員を作成しました'
        redirect_to users_worker_path(@worker)
      else
        render :new
      end
    end

    def show; end

    def edit
      @worker.worker_licenses.build if @worker.licenses.blank?
      @worker.worker_skill_trainings.build if @worker.skill_trainings.blank?
      @worker.worker_special_educations.build if @worker.special_educations.blank?
    end

    def update
      if @worker.update(worker_params)
        flash[:success] = '更新しました'
        redirect_to users_worker_path(@worker)
      else
        render :edit
      end
    end

    def destroy
      @worker.destroy
      flash[:danger] = "#{@worker.name}を削除しました"
      redirect_to users_workers_url
    end

    def update_license_images
      worker = current_business.workers.find(params[:worker_id])
      worker_license = worker.worker_licenses.find(params[:license_id])
      remain_images = worker_license.images
      deleted_image = remain_images.delete_at(params[:index].to_i)
      deleted_image.try(:remove!)
      worker_license.update!(images: remain_images)
      flash[:danger] = '免許証明画像を削除しました'
      redirect_to edit_users_worker_url(worker)
    end

    def update_skill_training_images
      worker = current_business.workers.find(params[:worker_id])
      worker_skill_training = worker.worker_skill_trainings.find(params[:skill_training_id])
      remain_images = worker_skill_training.images
      deleted_image = remain_images.delete_at(params[:index].to_i)
      deleted_image.try(:remove!)
      worker_skill_training.update!(images: remain_images)
      flash[:danger] = '技能講習証明画像を削除しました'
      redirect_to edit_users_worker_url(worker)
    end

    def update_special_education_images
      worker = current_business.workers.find(params[:worker_id])
      worker_special_education = worker.worker_special_educations.find(params[:special_education_id])
      remain_images = worker_special_education.images
      deleted_image = remain_images.delete_at(params[:index].to_i)
      deleted_image.try(:remove!)
      worker_special_education.update!(images: remain_images)
      flash[:danger] = '特別教育証明画像を削除しました'
      redirect_to edit_users_worker_url(worker)
    end

    # def update_images
    #   worker = current_business.workers.find(params[:worker_id])
    #   remain_images = worker.images
    #   deleted_image = remain_images.delete_at(params[:index].to_i)
    #   deleted_image.try(:remove!)
    #   worker.update!(images: remain_images)
    #   flash[:danger] = '添付画像を削除しました'
    #   redirect_to edit_users_worker_url(worker)
    # end

    private

    def set_worker
      @worker = current_business.workers.find(params[:id])
    end

    def worker_params
      params.require(:worker).permit(:name, :name_kana,
        :country, :my_address, :my_phone_number, :family_address,
        :family_phone_number, :birth_day_on, :abo_blood_type,
        :rh_blood_type, :job_type, :hiring_on, :experience_term_before_hiring,
        :blank_term, :carrier_up_id, { images: [] },
        worker_licenses_attributes: [:id, :license_id, :got_on, { images: [] }, :_destroy],
        worker_skill_trainings_attributes: [:id, :skill_training_id, :got_on, { images: [] }, :_destroy],
        worker_special_educations_attributes: [:id, :special_education_id, :got_on, { images: [] }, :_destroy]
      )
    end
  end
end
