# frozen_string_literal: true

module Users
  class BusinessesController < Users::Base
    def new
      @business = Business.new
    end

    def create
      redirect_to new_users_business_path # 仮redirect
    end

    def edit
    end

    def update
    end

    def show
    end

    private

      def business_params
        params.require(:business).permit(
                                          :uuid,
                                          :name,
                                          :name_kana,
                                          :branch_name,
                                          :representative_name,
                                          :email, :address,
                                          :post_code, :phone_number,
                                          :carrier_up_id,
                                          :stamp_images,
                                          :business_type,
                                          :user_id
                                        )
      end
  end
end
