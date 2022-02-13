class CreateLicenses < ActiveRecord::Migration[6.1]
  def change
    create_table :licenses do |t|
      t.string :name, null: false
      t.string :description
      t.integer :type, null: false

      t.timestamps
    end
  end
end
