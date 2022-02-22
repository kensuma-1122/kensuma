module Users
  class OrdersController < Users::Base
    def index
      @orders = current_business.orders.all
    end

    def show; end

    def new; end

    def edit; end

    def create; end

    def update; end

    def destroy; end
  end
end

