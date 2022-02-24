class AddCulumnsInCarVoluntaryInsurances < ActiveRecord::Migration[6.1]
  def change
    add_column :car_voluntary_insurances, :voluntary_securities_number, :string
    add_column :car_voluntary_insurances, :voluntary_insurance_start_on, :date
    add_column :car_voluntary_insurances, :voluntary_insurance_end_on, :date
  end
end
