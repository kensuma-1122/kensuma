module Users
  class DocumentsController < Users::Base
    layout 'documents'
    before_action :set_documents # サイドバーに常時表示させるために必要
    before_action :set_document, except: :index # オブジェクトが1つも無い場合、indexで呼び出さないようにする

    def index; end

    def show
      respond_to do |format|
        format.html
        format.pdf do
          case @document.document_type
          when 'cover_document', 'table_of_contents_document', 'doc_2nd', 'doc_8th'
            render pdf: '書類',
              layout: 'pdf',
              encording: 'UTF-8',
              page_size: 'A4'
          when 'doc_5th'
            render pdf: '書類',
              layout: 'pdf',
              encording: 'UTF-8',
              page_size: 'A4',
              margin: { top: 0 },
              orientation: 'Landscape'
          end
        end
      end
    end

    def edit; end

    def update
      if update_document(@document)
        flash[:success] = '更新に成功しました'
        redirect_to users_request_order_document_url
      else
        flash[:danger] = '更新に失敗しました'
        render :edit
      end
    end

    private

    def set_documents
      @documents = current_business.request_orders.find_by(uuid: params[:request_order_uuid]).documents.order(id: :asc)
    end

    def set_document
      @document = current_business.request_orders.find_by(uuid: params[:request_order_uuid]).documents.find_by(uuid: params[:uuid])
    end

    # 更新書類の判定
    def update_document(document)
      case document.document_type
      when 'cover_document'
        document.update(cover_params)
      when 'doc_2nd'
        document.update(doc_2nd_params)
      when 'doc_5th'
        document.update(doc_5th_params)
      when 'doc_8th'
        document.update(doc_8th_params)
      end
    end

    # 表紙
    def cover_params
      params.require(:document).permit.merge(
        content: {
          business_name: params[:document][:content][0],
          submitted_on:  params[:document][:content][1]
        })
    end

    # 施工体制台帳作成建設工事の通知
    def doc_2nd_params
      params.require(:document).permit.merge(
        content: {
          submitted_on:           params[:document][:content][0],
          prime_contractor_name:  params[:document][:content][1],
          site_name:              params[:document][:content][2],
          business_name:          params[:document][:content][3],
          orderer_name:           params[:document][:content][4],
          construction_name:      params[:document][:content][5],
          supervisor_name:        params[:document][:content][6],
          apply:                  params[:document][:content][7],
          submission_destination: params[:document][:content][8]
        }
      )
    end

    # 作業員名簿
    def doc_5th_params
      params.require(:document).permit.merge(
        content: {
          doc5_8_001_business_name:         params.dig(:document, :content, :doc5_8_001_business_name),
          doc5_8_002_site_id:               params.dig(:document, :content, :doc5_8_002_site_id),
          doc5_8_003_site_agent:            params.dig(:document, :content, :doc5_8_003_site_agent),
          doc5_8_004_created_date:          params.dig(:document, :content, :doc5_8_004_created_date),
          doc5_8_005_primary_business_name: params.dig(:document, :content, :doc5_8_005_primary_business_name),
          doc5_8_006_primary_business_id:   params.dig(:document, :content, :doc5_8_006_primary_business_id),
          doc5_8_007_hierarchy:             params.dig(:document, :content, :doc5_8_007_hierarchy),
          doc5_8_009_my_business_name:      params.dig(:document, :content, :doc5_8_009_my_business_name),
          doc5_8_010_my_business_id:        params.dig(:document, :content, :doc5_8_010_my_business_id),
          doc5_8_011_submitted_on:          params.dig(:document, :content, :doc5_8_011_submitted_on),
          doc5_8_042_confirmation:          params.dig(:document, :content, :doc5_8_042_confirmation),
          worker:                           {
            doc5_8_012_furigana:                        params.dig(:document, :content, :worker, :doc5_8_012_furigana),
            doc5_8_013_worker_name:                     params.dig(:document, :content, :worker, :doc5_8_013_worker_name),
            doc5_8_014_skilled_person_id:               params.dig(:document, :content, :worker, :doc5_8_014_skilled_person_id),
            doc5_8_015_occupation:                      params.dig(:document, :content, :worker, :doc5_8_015_occupation),
            doc5_8_016_symbol:                          params.dig(:document, :content, :worker, :doc5_8_016_symbol),
            doc5_8_017_employment_date:                 params.dig(:document, :content, :worker, :doc5_8_017_employment_date),
            doc5_8_018_years_of_experience:             params.dig(:document, :content, :worker, :doc5_8_018_years_of_experience),
            doc5_8_019_birthday:                        params.dig(:document, :content, :worker, :doc5_8_019_birthday),
            doc5_8_020_age:                             params.dig(:document, :content, :worker, :doc5_8_020_age),
            doc5_8_021_address:                         params.dig(:document, :content, :worker, :doc5_8_021_address),
            doc5_8_022_family_contact_address:          params.dig(:document, :content, :worker, :doc5_8_022_family_contact_address),
            doc5_8_023_telephone_number:                params.dig(:document, :content, :worker, :doc5_8_023_telephone_number),
            doc5_8_024_family_telephone_number:         params.dig(:document, :content, :worker, :doc5_8_024_family_telephone_number),
            doc5_8_025_health_check_date:               params.dig(:document, :content, :worker, :doc5_8_025_health_check_date),
            doc5_8_026_maximum_blood_pressure:          params.dig(:document, :content, :worker, :doc5_8_026_maximum_blood_pressure),
            doc5_8_027_minimum_blood_pressure:          params.dig(:document, :content, :worker, :doc5_8_027_minimum_blood_pressure),
            doc5_8_028_blood_type:                      params.dig(:document, :content, :worker, :doc5_8_028_blood_type),
            doc5_8_029_special_health_examination_date: params.dig(:document, :content, :worker,
              :doc5_8_029_special_health_examination_date),
            doc5_8_030_special_health_check_type:       params.dig(:document, :content, :worker, :doc5_8_030_special_health_check_type),
            doc5_8_031_health_insurance:                params.dig(:document, :content, :worker, :doc5_8_031_health_insurance),
            doc5_8_032_pension_insurance:               params.dig(:document, :content, :worker, :doc5_8_032_pension_insurance),
            doc5_8_033_employment_insurance_number:     params.dig(:document, :content, :worker, :doc5_8_033_employment_insurance_number),
            doc5_8_034_severance_pay:                   params.dig(:document, :content, :worker, :doc5_8_034_severance_pay),
            doc5_8_035_severance_pay_businesses:        params.dig(:document, :content, :worker, :doc5_8_035_severance_pay_businesses),
            doc5_8_036_special_education:               params.dig(:document, :content, :worker, :doc5_8_036_special_education),
            doc5_8_037_skill_training:                  params.dig(:document, :content, :worker, :doc5_8_037_skill_training),
            doc5_8_038_licence:                         params.dig(:document, :content, :worker, :doc5_8_038_licence),
            doc5_8_039_beginning:                       params.dig(:document, :content, :worker, :doc5_8_039_beginning),
            doc5_8_040_new_education:                   params.dig(:document, :content, :worker, :doc5_8_040_new_education),
            doc5_8_041_notebook:                        params.dig(:document, :content, :worker, :doc5_8_041_notebook)
          }
        }
      )
    end

    # 工事用・通勤用車両届
    def doc_8th_params
      params.require(:document).permit.merge(
        content: {
          prime_contractor_confirmation:                        params[:document][:content][0],  # 「元請会社の確認欄」12-001
          submitted_on:                                         params[:document][:content][1],  # 「提出日（西暦）」12-002
          construction_or_commute1:                             params[:document][:content][2],  # 工事用 or 通勤用 12-003
          business_name:                                        params[:document][:content][3],  # 「事業所名」12-004
          prime_contractor_name:                                params[:document][:content][4],  # 「一次会社名」12-006
          business_director:                                    params[:document][:content][5],  # 「各会社の現場代理人名」12-005
          subcontractor_name:                                   params[:document][:content][6],  # 自社の「会社名」12-008
          subcontructor_number:                                 params[:document][:content][7],  # 「〇次」12-007
          site_supervisor:                                      params[:document][:content][8],  # 「各会社の現場代理人」12-009
          seal:                                                 params[:document][:content][9],  # 印鑑 12-010
          construction_or_commute2:                             params[:document][:content][10], # 工事用 or 通勤用12-011
          start_of_use:                                         params[:document][:content][11], # 各車両の「使用期間・始期（西暦）」12-012
          end_of_use:                                           params[:document][:content][12], # 「各車両の使用期間・終期（西暦）」12-013
          vehicle_owner:                                        params[:document][:content][13], # 各車両の「車両所有者名」12-014
          safety_drive_administrator:                           params[:document][:content][14], # 各車両の「安全運転管理者」12-015
          vehicle_type:                                         params[:document][:content][15], # 各車両の「車両型式」12-016
          vehicle_number:                                       params[:document][:content][16], # 各車両の「車両番号」12-017
          start_of_valid_vehicle_inspection:                    params[:document][:content][17], # 各車両の「車検期間・始期（西暦）」12-018
          end_of_valid_vehicle_inspection:                      params[:document][:content][18], # 各車両の「車検期間・終期（西暦）」12-019
          vehicle_operator_name:                                params[:document][:content][19], # 作業員情報の「氏名」12-020
          vehicle_operator_birth_date:                          params[:document][:content][20], # 作業員情報の「生年月日」12-021
          vehicle_operator_address:                             params[:document][:content][21], # 作業員情報の「住所」12-022
          vehicle_operator_driving_license_type:                params[:document][:content][22], # 作業員情報の「自動車運転免許の種類」12-023
          vehicle_operator_driving_license_number:              params[:document][:content][23], # 作業員情報の「自動車運転免許の番号」12-024
          vehicle_liability_insurance_company_name:             params[:document][:content][24], # 各車両の「自賠責保険会社名」12-025
          vehicle_liability_insurance_number:                   params[:document][:content][25], # 各車両の「自賠責保険の証券番号」12-026
          vehicle_liability_insurance_start_of_validity:        params[:document][:content][26], # 各車両の「自賠責保険期間・始期（西暦）」12-027
          vehicle_liability_insurance_end_of_validity:          params[:document][:content][27], # 各車両の「自賠責保険期間・終期（西暦）」12-028
          voluntary_insurance_company_name:                     params[:document][:content][28], # 各車両の「任意保険会社名」12-029
          voluntary_insurance_number:                           params[:document][:content][29], # 各車両の「任意保険の証券番号」12-030
          voluntary_insurance_bodily_injury_liability_amount:   params[:document][:content][30], # 各車両の「任意保険の対人」12-031
          voluntary_insurance_property_damage_liability_amount: params[:document][:content][31], # 各車両の「任意保険の対物」12-032
          voluntary_insurance_start_of_validity:                params[:document][:content][32], # 各車両の「任意保険期間・始期（西暦）」12-033
          voluntary_insurance_end_of_validity:                  params[:document][:content][33], # 各車両の「任意保険期間・終期（西暦）」12-034
          departing_from:                                       params[:document][:content][34], # 各車両の「運行経路(自)」12-035
          routing_point1:                                       params[:document][:content][35], # 各車両の「運行経路の経由地1」12-036
          routing_point2:                                       params[:document][:content][36], # 各車両の「運行経路の経由地2」12-037
          arriving_at:                                          params[:document][:content][37]  # 各車両の「目的地（至）」12-038
        }
      )
    end
  end
end
