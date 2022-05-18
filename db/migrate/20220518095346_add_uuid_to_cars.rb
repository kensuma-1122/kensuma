class AddUuidToCars < ActiveRecord::Migration[6.1]
  def change
    add_column :cars, :uuid, :string, null: false
  end
end
