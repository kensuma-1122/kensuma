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
        # 表紙
        request_order.documents.build(
          document_type: 0,
          created_on:    Date.current,
          submitted_on:  Date.current,
          content:       {
            'business_name': '1', # 1-1
            'submitted_on':  '' # 1-2
          },
          business:      current_business
        )

        # 目次
        request_order.documents.build(
          document_type: 1,
          created_on:    Date.current,
          submitted_on:  Date.current,
          content:       {},
          business:      current_business
        )

        # 施工体制台帳作成建設工事の通知
        request_order.documents.build(
          document_type: 2,
          created_on:    Date.current,
          submitted_on:  Date.current,
          content:       {
            'submitted_on':           '', # 3-1
            'prime_contractor_name':  '', # 3-2
            'site_name':              '', # 3-3
            'business_name':          '', # 3-4
            'orderer_name':           '', # 3-5
            'construction_name':      '', # 3-6
            'supervisor_name':        '', # 3-7
            'apply':                  '', # 3-8
            'submission_destination': ''  # 3-9
          },
          business:      current_business
        )

        # 作業員名簿
        request_order.documents.build(
          document_type: 5,
          created_on:    Date.current,
          submitted_on:  Date.current,
          content:       {
            doc5_8_001_business_name: '', doc5_8_002_site_id: '', doc5_8_003_site_agent: '', doc5_8_004_created_date: '', doc5_8_005_primary_business_name: '',
            doc5_8_006_primary_business_id: '', doc5_8_007_hierarchy: '', doc5_8_009_my_business_name: '', doc5_8_010_my_business_id: '', doc5_8_011_submitted_on: '', doc5_8_042_confirmation: '',
            worker: [
              "{
                \"worker_medical\":{\"med_exam_on\":\"\"},
                \"worker_insurance\":{\"health_insurance_type\":\"\"},
                \"worker_skill_trainings\":{},
                \"worker_special_educations\":{},
                \"worker_licenses\":{}
              }"
            ]
          },
          business:      current_business
        )

        # 工事・通勤用車両届
        request_order.documents.build(
          document_type: 8,
          created_on:    Date.current,
          submitted_on:  Date.current,
          content:       {
            'prime_contractor_confirmation':                        '',
            'submitted_on':                                         '',
            'construction_or_commute1':                             '',
            'business_name':                                        '',
            'prime_contractor_name':                                '',
            'business_director':                                    '',
            'subcontractor_name':                                   '',
            'subcontructor_number':                                 '◯',
            'site_supervisor':                                      '',
            'seal':                                                 '印',
            'construction_or_commute2':                             '',
            'start_of_use':                                         '',
            'end_of_use':                                           '',
            'vehicle_owner':                                        '',
            'safety_drive_administrator':                           '',
            'vehicle_type':                                         '',
            'vehicle_number':                                       '',
            'start_of_valid_vehicle_inspection':                    '',
            'end_of_valid_vehicle_inspection':                      '',
            'vehicle_operator_name':                                '',
            'vehicle_operator_birth_date':                          '',
            'vehicle_operator_address':                             '',
            'vehicle_operator_driving_license_type':                '',
            'vehicle_operator_driving_license_number':              '',
            'vehicle_liability_insurance_company_name':             '',
            'vehicle_liability_insurance_number':                   '',
            'vehicle_liability_insurance_start_of_validity':        '',
            'vehicle_liability_insurance_end_of_validity':          '',
            'voluntary_insurance_company_name':                     '',
            'voluntary_insurance_number':                           '',
            'voluntary_insurance_bodily_injury_liability_amount':   '',
            'voluntary_insurance_property_damage_liability_amount': '',
            'voluntary_insurance_start_of_validity':                '',
            'voluntary_insurance_end_of_validity':                  '',
            'departing_from':                                       '',
            'routing_point1':                                       '',
            'routing_point2':                                       '',
            'arriving_at':                                          ''
          },
          business:      current_business
        )

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
