class AddParentIdToRequestOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :request_orders, :parent_id, :integer
  end
end
