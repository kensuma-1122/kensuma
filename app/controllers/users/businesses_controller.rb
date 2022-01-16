# frozen_string_literal: true

module Users
  class BusinessesController < Users::Base
    before_action :set_user_business, only: %i[edit update show]

    def new
      @business = Business.new
    end

    def create
      # テスト用デフォルト値 ==========================================
      @business =
        current_user.build_business(
          name:                "#{current_user.name}会社",
          name_kana:           'テストガイシャ',
          branch_name:         'テスト支店',
          representative_name: current_user.name.to_s,
          email:               "#{SecureRandom.alphanumeric(10)}@email.com",
          address:             "テスト住所#{rand(1..99)}-#{rand(1..99)}",
          post_code:           "#{rand(100..199)}-#{rand(100..199)}",
          phone_number:        "03-#{rand(1111..9999)}-#{rand(1111..9999)}",
          carrier_up_id:       SecureRandom.alphanumeric(20).to_s,
          business_type:       'corporation'
        )
      # =============================================================
      if @business.save!
        redirect_to users_dash_boards_path, flash: { success: "#{@business.name}を登録しました。" }
      else
        render :new
      end
    end

    def edit; end

    def update
      if @business.update(business_params)
        redirect_to users_business_path, flash: { success: "#{@business.name}を更新しました。" }
      else
        render :edit
      end
    end

    def show; end

    private

    def set_user_business
      @business = current_user.business
    end

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
        { stamp_images: [] },
        :remove_stamp_images,
        :business_type,
        :user_id
      )
    end
  end
end
