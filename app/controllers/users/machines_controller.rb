module Users
  class MachinesController < Users::Base
    before_action :set_machine, except: %i[index, new, create]

    def index
      @machines = current_business.machines
    end

    def new
      @machine = current_business.machines.new(
        # テスト用デフォルト値 ==========================
        name:                   "サンプルマシーン",
        standards_performance:  "サンプル規格・性能",
        control_number:         "サンプル管理番号",
        inspector:              "サンプル管理者",
        handler:                "サンプル取扱者",
        inspection_date:        Date.today,
        inspection_note:        "サンプル点検",
        inspection_check:       1,
        # ============================================
      )
    end

    def create
      @machine = current_business.machines.build(machine_params)
      if @machine.save
        flash[:success] = "機械情報を登録しました"
        redirect_to users_machines_url(@machine)
      else
        render :new
      end
    end

    def show; end

    def edit; end

    def update
      if @machine.update(machine_params)
        flash[:success] = '更新しました'
        redirect_to users_machines_url
      else
        render 'edit'
      end
    end

    def destroy
      @machine.destroy!
      flash[:danger] = "#{@machine.name}を削除しました"
      redirect_to users_machines_url
    end


    private
      def set_machine
        @machine = current_business.machines.find_by(uuid: params[:uuid])
      end

      def machine_params
        params.require(:machine).permit(
          :name, :standards_performance, :control_number, :inspector, :handler,
          :inspection_date, :inspection_note, :inspection_check
        )
      end
  end
end
