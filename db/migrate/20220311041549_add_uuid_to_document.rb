class AddUuidToDocument < ActiveRecord::Migration[6.1]
  def change
    add_column :documents, :uuid, :string, null: false
  end
end
