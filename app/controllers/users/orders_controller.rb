module Users
  class OrdersController < Users::Base
    before_action :set_business_workers_name, only: %i[new create edit update]
    before_action :set_order, except: %i[index new create]

    def index
      @orders = current_business.orders
    end

    def show; end

    def new
      @order = current_business.orders.new(
        # テスト用デフォルト値 ==========================
        site_career_up_id:                          '1234-5678-9000',
        site_name:                                  Faker::Company.name,
        site_address:                               current_business.address,

        order_name:                                 Faker::Company.name,
        order_post_code:                            current_business.post_code,
        order_address:                              current_business.address,
        order_supervisor_name:                      Faker::Name.name,
        order_supervisor_company:                   Faker::Company.name,
        order_supervisor_apply:                     %w[基本契約約款の通り 契約書に準拠する 口頭及び文書による].sample,

        construction_name:                          '工事名',
        construction_details:                       '工事内容',
        start_date:                                 Date.today,
        end_date:                                   Date.today.next_month,
        contract_date:                              Date.today.prev_month,
        submission_destination:                     '提出部･提出先名',
        general_safety_responsible_person_name:     '統括安全衛生責任者名',
        vice_president_name:                        '副会長名',
        vice_president_company_name:                '副会長会社',
        secretary_name:                             '書記名',
        health_and_safety_manager_name:             '元方安全衛生管理者名',
        general_safety_agent_name:                  '統括安全衛生責任者代行者',
        supervisor_name:                            '現場監督員名',
        supervisor_apply:                           %w[基本契約約款の通り 契約書に準拠する 口頭及び文書による].sample,
        site_agent_name:                            '現場代理人名',
        site_agent_apply:                           %w[基本契約約款の通り 契約書に準拠する 口頭及び文書による].sample,
        supervising_engineer_name:                  '監督技術者･主任技術者名',
        supervising_engineer_check:                 [0, 1].sample,
        supervising_engineer_assistant_name:        '監督技術者補佐名',
        professional_engineer_name:                 '専門技術者名',
        professional_engineer_construction_details: '専門技術者(担当工事内容)',
        safety_officer_name:                        '安全衛生担当役名',
        safety_officer_position_name:               '安全衛生担当役員(役職名)',
        general_safety_manager_name:                '総括安全衛生管理者名',
        general_safety_manager_position_name:       '総括安全衛生管理(役職名)',
        safety_manager_name:                        '安全管理者名',
        safety_manager_position_name:               '安全管理者(役職名)',
        health_manager_name:                        '衛生管理者名',
        health_manager_position_name:               '衛生管理者(役職名)',
        health_and_safety_promoter_name:            '安全衛生推進者名',
        health_and_safety_promoter_position_name:   '安全衛生推進者(役職名)',
        confirm_name:                               '確認欄(氏名)',
        accept_confirm_date:                        Date.yesterday,
        subcontractor_name:                         '下請会社'
        # =============================================
      )
    end

    def create
      ActiveRecord::Base.transaction do
        @order = current_business.orders.build(order_params)
        request_order = @order.request_orders.build(business: current_business)

        24.times do |n|
          request_order.documents.build(
            document_type: n + 1,
            created_on:    Date.current,
            submitted_on:  Date.current,
            business:      current_business
          )
        end

        if @order.save!
          redirect_to users_order_url(@order)
        end
      end
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = '登録に失敗しました。再度作成してください。'
      redirect_to new_users_order_path
    end

    def edit; end

    def update
      if @order.update(order_params)
        flash[:success] = '更新しました'
        redirect_to users_order_url
      else
        render :edit
      end
    end

    def destroy
      @order.destroy!
      flash[:danger] = "#{@order.site_uu_id}を削除しました"
      redirect_to users_orders_url
    end

    private

    def set_order
      @order = current_business.orders.find_by(site_uu_id: params[:site_uu_id])
    end

    def order_params
      params.require(:order).permit(
        :status,
        :site_career_up_id,
        :site_name,
        :site_address,
        :order_name,
        :order_post_code,
        :order_address,
        :order_supervisor_name,
        :order_supervisor_company,
        :order_supervisor_apply,
        :construction_name,
        :construction_details,
        :start_date, :end_date,
        :contract_date,
        :submission_destination,
        :general_safety_responsible_person_name,
        :vice_president_name,
        :vice_president_name,
        :vice_president_company_name,
        :secretary_name,
        :health_and_safety_manager_name,
        :general_safety_agent_name,
        :supervisor_name,
        :supervisor_apply,
        :site_agent_name,
        :site_agent_apply,
        :supervising_engineer_name,
        :supervising_engineer_check,
        :supervising_engineer_assistant_name,
        :professional_engineer_name,
        :professional_engineer_construction_details,
        :safety_officer_name,
        :safety_officer_position_name,
        :general_safety_manager_name,
        :general_safety_manager_position_name,
        :safety_manager_name,
        :safety_manager_position_name,
        :health_manager_name,
        :health_manager_position_name,
        :health_and_safety_promoter_name,
        :health_and_safety_promoter_position_name,
        :confirm_name,
        :accept_confirm_date,
        :subcontractor_name
      )
    end
  end
end
