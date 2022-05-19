module Users
  class OrdersController < Users::Base
    before_action :set_order, except: %i[index new create]

    def index
      @orders = current_business.orders
    end

    def show; end

    def new
      @order = current_business.orders.new(
        # テスト用デフォルト値 ==========================
        site_name:  current_business.name,
        order_name: current_user.name
        # order_post_code: current_business.post_code,
        # order_address:   current_business.address
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
      params.require(:order).permit(:status, :site_name, :order_name, :order_post_code, :order_address)
    end
  end
end
