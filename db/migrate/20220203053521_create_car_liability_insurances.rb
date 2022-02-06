class CreateCarLiabilityInsurances < ActiveRecord::Migration[6.1]
  def change
    create_table :car_liability_insurances do |t|
      t.integer :car_id, null: false
      t.integer :car_insurance_company_id, null: false

      t.timestamps
    end
    add_index :car_liability_insurances, [:car_id], unique: true
  end
end
