module Users
  class SubRequestOrdersController < Users::Base
    before_action :set_request_order, only: %i[new create]

    def index; end

    def new
      @businesses = Business.where.not(id: current_business)
      @sub_request_order = @request_order.order.request_orders.new
    end

    def create
      select_businesses = params[:request_order][:business_id]

      select_businesses.each do |select_business|
        RequestOrder.create!(business_id: select_business, order: @request_order.order, parent_id: @request_order.id)
      end
      flash[:success] = "#{select_businesses.count}件の発注依頼を作成しました"
      redirect_to users_request_order_url(@request_order)
      # @sub_request_order = @request_order.order.request_orders.build(sub_request_order_params)
      # if @sub_request_order.save
      #   flash[:success] = '発注依頼を作成しました'
      #   redirect_to users_request_order_url(@request_order)
      # else
      #   render :new
      # end
    end

    def edit; end

    def update; end

    private

    def set_request_order
      @request_order = current_business.request_orders.find_by(uuid: params[:request_order_uuid])
    end

    # def sub_request_order_params
    #   params.require(:request_order).permit(:business_id).merge(parent_id: @request_order.id)
    # end
  end
end
