class CreateBusinesses < ActiveRecord::Migration[6.1]
  def change
    create_table :businesses do |t|
      t.string :uuid, null: false
      t.string :name, null: false
      t.string :name_kana, null: false
      t.string :branch_name, null: false
      t.string :representative_name, null: false
      t.string :email, null: false
      t.string :address, null: false
      t.string :post_code, null: false
      t.string :phone_number, null: false
      t.string :carrier_up_id
      t.string :stamp_images
      t.integer :business_type, null: false
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
