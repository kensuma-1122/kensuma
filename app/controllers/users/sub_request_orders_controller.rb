module Users
  class SubRequestOrdersController < Users::Base
    before_action :set_request_order

    def index; end

    def new
      @businesses = Business.where.not(id: current_business)
    end

    def create
      ActiveRecord::Base.transaction do
        params[:business_ids].each do |business_id|
          @request_order.order.request_orders.create!(business_id: business_id, parent_id: @request_order.id)
        end
        flash[:success] = "#{params[:business_ids].count}件の発注依頼を作成しました。"
        redirect_to users_request_order_url(@request_order)
      end
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = '発注依頼に失敗しました。再度作成してください。'
      redirect_to new_users_request_order_sub_request_order_path
    end

    def update; end

    private

    def set_request_order
      @request_order = current_business.request_orders.find_by(uuid: params[:request_order_uuid])
    end
  end
end
