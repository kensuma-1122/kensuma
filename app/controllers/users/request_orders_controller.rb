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
      if @request_order.children.all? { |r| r.status == 'submitted' }
        @request_order.submitted!
        flash[:success] = '発注依頼を提出済にしました'
      else
        flash[:danger] = '下請けがまだ編集中です'
      end
      redirect_to users_request_order_path(@request_order)
    end

    def fix_request
    end

    def approve
    end
  end
end
