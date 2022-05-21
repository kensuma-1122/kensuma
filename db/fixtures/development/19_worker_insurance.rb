Worker.all.each do |worker|
  WorkerInsurance.seed(:id,
    {
      id: worker.id,
      worker_id:         worker.id,
      health_insurance_type:         :national_health_insurance,
      health_insurance_name:         :construction_national_health_insurance,
      pension_insurance_type:        :welfare,
      employment_insurance_type:     :day,
      employment_insurance_number:   '1234',
      severance_pay_mutual_aid_type: :kentaikyo,
    }
  )
end
