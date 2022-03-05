module Users
  class RequestOrdersController < Users::Base
    def index
      @request_orders = current_business.request_orders
    end

    def show
      @request_order = current_business.request_orders.find_by(uuid: params[:uuid])
    end
  end
end
