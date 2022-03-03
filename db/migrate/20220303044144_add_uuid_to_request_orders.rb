class AddUuidToRequestOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :request_orders, :uuid, :string
  end
end
