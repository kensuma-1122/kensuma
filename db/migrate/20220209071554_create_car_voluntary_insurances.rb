class CreateCarVoluntaryInsurances < ActiveRecord::Migration[6.1]
  def change
    create_table :car_voluntary_insurances do |t|
      t.references :car, index: true, foreign_key: true
      t.references :car_insurance_company, index: true, foreign_key: true
      t.integer :personal_insurance
      t.integer :objective_insurance

      t.timestamps
    end
  end
end
