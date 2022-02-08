class CreateCarLiabilityInsurances < ActiveRecord::Migration[6.1]
  def change
    create_table :car_liability_insurances do |t|
      t.references :car_liability, index: { unique: true }, foreign_key: { to_table: :cars }, null: false
      t.references :company_liability, foreign_key: { to_table: :car_insurance_companies }, null: false

      t.timestamps
    end
  end
end
