module Users
  class GeneralUsersController < Users::Base
    def index; end

    def show
      @general_user = current_user.general_users.find(params[:id])
    end

    def new
      @general_user = User.new
    end

    def create
      puts @general_user = User.new(general_user_params)
      if @general_user.save
        redirect_to users_general_user_url
      else
        render :new
      end
    end

    def edit; end

    def update; end

    private

    def general_user_params
      params.require(:user).permit(
        :email, :password, :password_confirmation, :name, :age, :gender
      ).merge(admin_user_id: current_user.id)
    end
  end
end
