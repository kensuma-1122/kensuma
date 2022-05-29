module Users
  class RequestOrdersController < Users::Base
    before_action :set_request_order, except: :index
    before_action :set_sub_request_order, only: %i[fix_request approve]

    def index
      @request_orders = current_business.request_orders
    end

    def show
      @sub_request_orders = @request_order.children
      @all_children = @request_order.hash_tree
    end

    def submit
      if @request_order.parent_id.nil? && @request_order.children.all? { |r| r.status == 'approved' }
        @request_order.approved!
        flash[:success] = '発注依頼を承認しました'
      elsif @request_order.children.all? { |r| r.status == 'approved' }
        @request_order.submitted!
        flash[:success] = '発注依頼を提出済にしました'
      else
        flash[:danger] = '下請けの書類がまだ未承認です'
      end
      redirect_to users_request_order_path(@request_order)
    end

    def fix_request
      @sub_request_order.fix_requested!
      flash[:warning] = "#{@sub_request_order.business.name}の書類を差し戻ししました"
      redirect_to users_request_order_path(@request_order)
    end

    def approve
      @sub_request_order.approved!
      flash[:success] = "#{@sub_request_order.business.name}の書類を承認しました"
      redirect_to users_request_order_path(@request_order)
    end

    private

    def set_request_order
      @request_order = current_business.request_orders.find_by(uuid: params[:uuid])
    end

    def set_sub_request_order
      @sub_request_order = RequestOrder.find_by(uuid: params[:sub_request_uuid])
    end
  end
end
