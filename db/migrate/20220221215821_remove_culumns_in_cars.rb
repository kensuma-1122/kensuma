class RemoveCulumnsInCars < ActiveRecord::Migration[6.1]
  def change
    remove_column :cars, :voluntary_securities_number, :string
    remove_column :cars, :voluntary_insurance_start_on, :date
    remove_column :cars, :voluntary_insurance_end_on, :date
  end
end
