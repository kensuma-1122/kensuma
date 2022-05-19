Worker.all.each do |worker|
    WorkerInsurance.seed(:worker_id,
      {
        worker_id:              worker.id,
        health_insurance_type:  1,
        pension_insurance_type: 1,
        employment_insurance_type: 1,
        employment_insurance_number: '1234',
        severance_pay_mutual_aid_type: 1
      }
    )
end
