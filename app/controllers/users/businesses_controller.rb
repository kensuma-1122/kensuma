# frozen_string_literal: true

module Users
  class BusinessesController < Users::Base
    def new
      @business = Business.new(uuid: nil)
    end

    def create
      # テスト用値 ======================================================
      @business = 
        Business.new(
          uuid: nil,
          name: "テスト企業",
          name_kana: "テストキギョウ",
          branch_name: "テスト支店",
          representative_name: "代表太郎",
          email: "#{SecureRandom.alphanumeric(10)}@email.com",
          address: "テスト住所#{rand(1..99)}-#{rand(1..99)}",
          post_code: "#{rand(100..199)}-#{rand(100..199)}",
          phone_number: "03-#{rand(1111..9999)}-#{rand(1111..9999)}",
          carrier_up_id: "#{SecureRandom.alphanumeric(20)}",
          stamp_images: nil,
          business_type: "corporation",
          user_id: current_user.id
        )
      # =============================================================

      if @business.save
        redirect_to users_dash_boards_path, flash: { success: "#{@business.name}を登録しました。" }
      else
        render :new
      end
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
                                          :email,
                                          :address,
                                          :post_code,
                                          :phone_number,
                                          :carrier_up_id,
                                          :stamp_images,
                                          :business_type,
                                          :user_id
                                        )
      end
  end
end
