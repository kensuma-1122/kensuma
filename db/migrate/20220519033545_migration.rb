class Migration < ActiveRecord::Migration[6.1]
  def up
    add_column :cars, :uuid, :string, null:false
    add_column :workers, :uuid, :string, null:false
  end
end
