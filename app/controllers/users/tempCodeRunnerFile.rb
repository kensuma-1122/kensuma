car = current_business.cars.new(
       
        owner_name:                   current_user.name,
        safety_manager:               'anzen taro',
        vehicle_model:                'ZVW30',
        vehicle_number:               '12-34',
        vehicle_inspection_start_on:  Date.today,
        vehicle_inspection_end_on:    Date.today.since(3.years),
        liability_securities_number:  SecureRandom.hex(5),
        liability_insurance_start_on: Date.today,
        liability_insurance_end_on:   Date.today.next_year,
        voluntary_securities_number:  SecureRandom.hex(5),
        voluntary_insurance_start_on: Date.today,
        voluntary_insurance_end_on:   Date.today.next_year
        
      )