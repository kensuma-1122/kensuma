Worker.all.each do |worker|
    WorkerInsurance.seed(:id,
      {
        id: worker.id,
        worker_id:         worker.id,
        health_insurance_type:         :health_insurance_association,
        health_insurance_name:         'サンプル健康保険',
        pension_insurance_type:        :welfare,
        employment_insurance_type:     :insured,
        employment_insurance_number:   '0000',
        severance_pay_mutual_aid_type: :kentaikyo,
        severance_pay_mutual_aid_name: 'テスト共済制度'
      }
    )
  end