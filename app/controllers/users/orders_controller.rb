module Users
  class OrdersController < Users::Base
    before_action :set_order, except: %i[index new create]

    def index
      @orders = current_business.orders
    end

    def show; end

    def new
      @order = current_business.orders.new(
        # テスト用デフォルト値 ==========================
        site_name:       current_business.name,
        order_name:      current_user.name,
        order_post_code: current_business.post_code,
        order_address:   current_business.address
        # =============================================
      )
    end

    def create
      @order = current_business.orders.build(order_params)

      ActiveRecord::Base.transaction do
        if @order.save!
          @order.request_orders.create!(request_order_params)
          redirect_to users_order_url(@order)
        end
      end
    rescue ActiveRecord::RecordInvalid
      render :new
    rescue StandardError
      flash[:danger] = '登録処理にエラーが発生しました。再度入力してください。'
      redirect_to new_users_order_url
    end

    def edit; end

    def update
      if @order.update(order_params)
        flash[:success] = '更新しました'
        redirect_to users_order_url
      else
        render :edit
      end
    end

    def destroy
      @order.destroy!
      flash[:danger] = "#{@order.site_uu_id}を削除しました"
      redirect_to users_orders_url
    end

    private

    def set_order
      @order = current_business.orders.find_by(site_uu_id: params[:site_uu_id])
    end

    def order_params
      params.require(:order).permit(:status, :site_name, :order_name, :order_post_code, :order_address)
    end

    def request_order_params
      params.require(:order).permit(:status).merge(business_id: @current_business.id)
    end
  end
end
