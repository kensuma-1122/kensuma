class CreateRequestOrderHierarchies < ActiveRecord::Migration[6.1]
  def change
    create_table :request_order_hierarchies, id: false do |t|
      t.integer :ancestor_id, null: false
      t.integer :descendant_id, null: false
      t.integer :generations, null: false
    end

    add_index :request_order_hierarchies, [:ancestor_id, :descendant_id, :generations],
      unique: true,
      name: "request_order_anc_desc_idx"

    add_index :request_order_hierarchies, [:descendant_id],
      name: "request_order_desc_idx"
  end
end
