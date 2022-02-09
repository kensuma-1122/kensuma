class AddCarInsuranceCompanyIdToCar < ActiveRecord::Migration[6.1]
  def change
    add_reference :cars, :car_insurance_company, foreign_key: true
  end
end
