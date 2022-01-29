# frozen_string_literal: true

module Users
  class Base < ApplicationController
    before_action :authenticate_user!
    before_action :business_nil_access
    layout 'users'

    # 事業所が登録してあればダッシュボードへ
    def business_present_access
      redirect_to users_dash_boards_path if current_user.business.present?
    end

    # 事業所が登録してなければ事業所登録画面へ
    def business_nil_access
      redirect_to new_users_business_path, flash: { danger: '事業所を登録して下さい' } if current_user.business.nil?
    end
  end
end
