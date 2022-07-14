module Users::RequestOrders
  class FieldWorkersController < Users::Base
    before_action :set_request_order
    before_action :set_field_worker, only: %i[edit update destroy]

    def index
      @field_workers = @request_order.field_workers
    end

    def show; end

    def new
      @field_worker = @request_order.field_workers.new
    end

    def create
      @field_worker = @request_order.field_workers.build(field_worker_params)
      if @field_worker.save
        redirect_to users_request_order_field_workers_url
      else
        render :new
      end
    end

    def edit; end

    def update
      if @field_worker.update(field_worker_params)
        flash[:success] = "#{@field_worker.admission_worker_name}を更新しました"
        redirect_to users_request_order_field_workers_url
      else
        render 'edit'
      end
    end

    def destroy
      @field_worker.destroy!
      flash[:danger] = "#{@field_worker.admission_worker_name}を削除しました"
      redirect_to users_request_order_field_workers_url
    end

    private

    def set_request_order
      @request_order = current_business.request_orders.find_by(uuid: params[:request_order_uuid])
    end

    def set_field_worker
      @field_worker = @request_order.field_workers.find_by(uuid: params[:uuid])
    end

    def field_worker_params
      params.require(:field_worker).permit(:admission_worker_name, :admission_date_start, :admission_date_end, :education_date)
    end
  end
end
