module Users
  class OrdersController < Users::Base
    before_action :set_order, except: %i[index new create]

    def index
      @orders = current_business.orders.all
    end

    def show; end

    def new
      @order = current_business.orders.new(
        status:          0,
        site_name:       '現場A',
        order_name:      '発注者A',
        order_post_code: '0123456',
        order_address:   'TEST'
      )
    end

    def edit; end

    def create
      @order = current_business.orders.new(order_params)
      if @order.save
        redirect_to users_order_url(@order)
      else
        render :new
      end
    end

    def update
      if @order.update(order_params)
        flash[:success] = '更新しました'
        redirect_to users_order_url(@order)
      else
        render 'edit'
      end
    end

    def destroy
      @order.destroy
      flash[:danger] = "#{@order.site_name}を削除しました"
      redirect_to users_orders_url
    end

    private

    def set_order
      @order = current_business.orders.find_by(site_uu_id: params[:site_uu_id])
    end

    def order_params
      params.require(:order).permit(:status, :site_name, :order_name, :order_post_code, :order_address)
    end
  end
end
