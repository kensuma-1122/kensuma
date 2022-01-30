module Users
  class Users::CarsController < Users::Base
    before_action :car_set, except: %i[index new create update_images]

    def index
      @cars = @business.cars.all
    end

    def new
      @car = @business.cars.new(
        owner_name:                   'test車両所有者',
        safety_manager:               'test安全運転管理者',
        vehicle_model:                'test車両型式',
        vehicle_number:               'test車両番号',
        vehicle_inspection_start_on:  'Sat, 30 Jan 2020',
        vehicle_inspection_end_on:    'Sat, 30 Jan 2022',
        liability_securities_number:  'test自賠責証券番号',
        liability_insurance_start_on: 'Sat, 30 Jan 2020',
        liability_insurance_end_on:   'Sat, 30 Jan 2022',
        voluntary_securities_number:  'test任意保険証券番号',
        voluntary_insurance_start_on: 'Sat, 30 Jan 2020',
        voluntary_insurance_end_on:   'Sat, 30 Jan 2022'
      )
    end

    def create
      @car = @business.cars.new(car_params)
      if @car.save
        redirect_to users_car_url(@car)
      else
        render :new
      end
    end

    def edit; end

    def update
      if @car.update(car_params)
        flash[:success] = '更新しました'
        redirect_to users_car_url(@car)
      else
        render 'edit'
      end
    end

    def show; end

    def destroy
      @car.destroy
      flash[:danger] = "#{@car.owner_name}を削除しました"
      redirect_to users_cars_url
    end

    def update_images
      car = @business.cars.find(params[:car_id])
      # 残りimageを定義
      remain_images = car.images
      # imageを削除する
      deleted_image = remain_images.delete_at(params[:index].to_i)
      deleted_image.try(:remove!)
      # 削除した後のimageをupdateする
      car.update!(images: remain_images)
      flash[:danger] = '削除しました'
      redirect_to edit_users_car_url(car)
    end

    private

    def car_set
      @car = @business.cars.find(params[:id])
    end

    def car_params
      params.require(:car).permit(
        :owner_name, :safety_manager, :vehicle_model, :vehicle_number, :vehicle_inspection_start_on,
        :vehicle_inspection_end_on, :liability_securities_number, :liability_insurance_start_on,
        :liability_insurance_end_on, :voluntary_securities_number, :voluntary_insurance_start_on, :voluntary_insurance_end_on, { images: [] }
      )
    end
  end
end
