class ChangeColumnToNews < ActiveRecord::Migration[6.1]
  def change
    add_column :news, :uuid, :string, null: false
  end
end
