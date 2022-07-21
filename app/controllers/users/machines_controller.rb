module Users
  class CarsController < Users::Base
    before_action :set_machine

    def index
      @machines = current_business.machines
    end

    def new
      @machine = current_business.cars.new(
        # テスト用デフォルト値 ==========================
        owner_name:             current_user.name,
        name:                   "サンプルマシーン",
        standards_performance:  "サンプル規格・性能",
        control_number:         "サンプル管理番号",
        inspector:              "サンプル管理者",
        handler:                "サンプル取扱者",
        inspection_date:        Date.today,
        inspection_note:        "サンプル点検",
        inspection_check:       1,
        business_id:            current_business.id
        # ============================================
      )
    end

    def create
      @machine = current_business.machines.build(machine_params)
      if @machine.save
        redirect_to users_machines_url(@machine)
      else
        render :new
      end
    end

    private
      def set_machine
        @machine = current_business.machines.find_by(business_id: params(:business_id))
      end

      def machine_params
        params.require(:machine).permit(

        )
      end
  end
end
