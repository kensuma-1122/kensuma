module Users
  class SubRequestOrdersController < Users::Base
    before_action :set_request_order, only: %i[new create]

    def index
    end

    def new
      @businesses = Business.where.not(id: current_business.id)
      @sub_request_order = @request_order.order.request_orders.build
    end

    def create
    end

    def edit
    end

    def update
    end

    private

    def set_request_order
      @request_order = current_business.request_orders.find_by(uuid: params[:request_order_uuid])
    end
  end
end
