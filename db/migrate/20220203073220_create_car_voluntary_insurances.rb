class CreateCarVoluntaryInsurances < ActiveRecord::Migration[6.1]
  def change
    create_table :car_voluntary_insurances do |t|
      t.integer :personal_insurance, null: false
      t.integer :objective_insurance, null: false
      t.integer :car_id, null: false
      t.integer :car_insurance_company_id, null: false

      t.timestamps
    end
  end
end
