module Users
  class GeneralUsersController < Users::Base
    before_action :set_general_user, only: %i[show edit update destroy]

    def index
      @general_users = current_user.general_users
    end

    def show; end

    def new
      @general_user = User.new
    end

    def create
      @general_user = User.new(general_user_params)
      @general_user.skip_confirmation! # email認証スキップ
      if @general_user.save
        redirect_to users_general_user_url(@general_user), flash: { success: '登録しました' }
      else
        render :new
      end
    end

    def edit; end

    def update
      @general_user.skip_reconfirmation! # email認証スキップ
      if @general_user.update(general_user_params)
        redirect_to users_general_user_url(@general_user), flash: { success: "#{@general_user.name}を更新しました" }
      else
        render 'edit'
      end
    end

    def destroy
      @general_user.destroy
      redirect_to users_general_users_path, flash: { danger: "#{@general_user.name}を削除しました" }
    end

    private

    def set_general_user
      @general_user = current_user.general_users.find(params[:id])
    end

    def general_user_params
      params.require(:user).permit(
        :email, :password, :password_confirmation, :name, :age, :gender
      ).merge(admin_user_id: current_user.id)
    end
  end
end
