class CreateRequestOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :request_orders do |t|
      t.integer :status, default: 0

      t.references :order, foreign_key: true, null: false
      t.references :business, foreign_key: true, null: false

      t.timestamps
    end
  end
end
