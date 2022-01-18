# frozen_string_literal: true

class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    case resource
    when User
      business = resource.business
      if business.nil?
        new_users_business_path
      else
        users_dash_boards_path
      end
    when Admin
      admin_dashboard_path
    when Manager
      managers_dash_boards_path
    end
  end

  def configure_permitted_parameters
    added_attrs = %i[email name password password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end

  # 事業所が登録してあればダッシュボードへ、事業所が登録してなければ事業所登録画面へ
  def check_business_exist
    @business = current_user.business
    if @business.present?
      # URLが　"/users/business/new" または URLが "/users/business" ＆ メソッド名が "POST" であれば
      if request.fullpath == "/users/business/new" || request.fullpath == "/users/business" && request.method == "POST"
        flash[:danger] = '事業所はすでに登録済みです'
        redirect_to users_dash_boards_url
      end
    else
      # URLが　"/users/business/new" または URLが "/users/business" ＆ メソッド名が "POST" でなければ
      unless request.fullpath == "/users/business/new" || request.fullpath == "/users/business" && request.method == "POST"
        flash[:danger] = '事業所を登録して下さい'
        redirect_to new_users_business_url
      end
    end
    
  end
end
