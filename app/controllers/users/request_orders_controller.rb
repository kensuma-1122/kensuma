module Users
  class RequestOrdersController < Users::Base
    def index
      @request_orders = current_business.request_orders
    end

    def show
      @request_order = current_business.request_orders.find_by(uuid: params[:uuid])
      @sub_request_orders = @request_order.children
    end

    def submit
      @request_order = current_business.request_orders.find_by(uuid: params[:uuid])
      if @request_order.children.all? { |r| r.status == 'approved' }
        @request_order.submitted!
        flash[:success] = '発注依頼を提出済にしました'
      else
        flash[:danger] = '下請けの依頼がまだ未承認です'
      end
      redirect_to users_request_order_path(@request_order)
    end

    def fix_request
      @request_order = current_business.request_orders.find_by(uuid: params[:request_order_uuid])
      @sub_request_order = RequestOrder.find_by(uuid: params[:uuid])
      @sub_request_order.fix_requested!
      flash[:warning] = "#{@sub_request_order.business.name}の書類を差し戻ししました"
      redirect_to users_request_order_path(@request_order)
    end

    def approve
      @request_order = current_business.request_orders.find_by(uuid: params[:request_order_uuid])
      @sub_request_order = RequestOrder.find_by(uuid: params[:uuid])
      @sub_request_order.approved!
      flash[:success] = "#{@sub_request_order.business.name}の書類を承認しました"
      redirect_to users_request_order_path(@request_order)
    end
  end
end
