module Users
  class GeneralUsersController < Users::Base
    def index; end

    def show; end

    def new
      @general_user = User.new
    end

    def create
      redirect_to users_general_users_url # 仮
    end

    def edit; end

    def update; end
  end
end
