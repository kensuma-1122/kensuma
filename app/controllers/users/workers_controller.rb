module Users
  class WorkersController < Users::Base
    before_action :set_worker, only: [:show, :edit, :destroy]

    def index
      @workers = current_user.business.workers
    end

    def new
      @worker = Worker.new(
        name: 'TestWorker',
        name_kana: 'テストワーカー',
        country: '日本',
        my_address: '東京都',
        my_phone_number: '09012345678',
        family_address: '東京都',
        family_phone_number: '08087654321',
        birth_day_on: '2022-01-28',
        abo_blood_type: 0,
        rh_blood_type: 0,
        job_type: 0,
        hiring_on: '2022-01-28',
        experience_term_before_hiring: 1,
        blank_term: 1,
        carrier_up_id: '1'
      )
    end

    def create
      @worker = Worker.new(worker_params)
      if @worker.save
        redirect_to users_workers_url
      else
        render :new
      end
    end

    def show; end

    def edit; end

    def update
      if @worker.update(worker_params)
        flash[:success] = '更新しました'
        redirect_to users_workers_url
      else
        render 'edit'
      end
    end

    def destroy
      if @worker.destroy
        flash[:success] = "#{@worker.name}の情報を削除しました"
        redirect_to users_workers_url
      end
    end

    private
      def set_worker
        @worker = current_user.business.workers.find(params[:id])
      end

      def worker_params
        params.require(:worker).permit(:name, :name_kana, :country, :my_address, :my_phone_number, :family_address, :family_phone_number, :birth_day_on,
          :abo_blood_type, :rh_blood_type, :job_type, :hiring_on, :experience_term_before_hiring, :blank_term, :carrier_up_id, { images: [] }, :business_id)
      end
  end
end
