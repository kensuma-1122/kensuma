# frozen_string_literal: true

module Users
  class DashBoardsController < Users::Base
    def index
      redirect_to new_users_business_path if @business.nil?
    end
  end
end
