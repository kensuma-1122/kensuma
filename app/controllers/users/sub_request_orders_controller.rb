module Users
  class SubRequestOrdersController < Users::Base
    before_action :set_request_order, only: %i[new create]

    def index; end

    def new
      @businesses = Business.where.not(id: current_business)
      @sub_request_order = @request_order.order.request_orders.build
    end

    def create
      select_businesses = params[:request_order][:business_id]

      ActiveRecord::Base.transaction do
        select_businesses.each do |select_business|
          @request_order.order.request_orders.create!(business_id: select_business, parent_id: @request_order.id)
        end
        flash[:success] = "#{select_businesses.count}件の発注依頼を作成しました。"
        redirect_to users_request_order_url(@request_order)
      end
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = '発注依頼の作成に失敗しました、再度登録してください。'
      redirect_to new_users_request_order_sub_request_order_path
    end

    def edit; end

    def update; end

    private

    def set_request_order
      @request_order = current_business.request_orders.find_by(uuid: params[:request_order_uuid])
    end
  end
end
