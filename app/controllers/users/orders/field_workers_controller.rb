module Users::Orders
  class FieldWorkersController < Users::Base
    before_action :set_order

    def index
      @field_workers = @order.field_workers
    end

    def show; end

    def new
      @field_worker = @order.field_workers.new
    end

    def create
      @field_worker = @order.field_workers.build(field_worker_params)
      if @field_worker.save
        redirect_to users_order_field_workers_url
      else
        render :new
      end
    end

    def edit; end

    def update; end

    private

    def set_order
      @order = current_business.orders.find_by(site_uu_id: params[:order_site_uu_id])
    end

    def field_worker_params
      params.require(:field_worker).permit(:admission_worker_name, :admission_date_start, :admission_date_end, :education_date)
    end
  end
end
