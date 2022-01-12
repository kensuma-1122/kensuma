# frozen_string_literal: true

module Users
  class DashBoardsController < Users::Base
    def index
      redirect_to new_users_business_path unless Business.find_by(user_id: current_user.id)
    end
  end
end
