class AddToWorkers < ActiveRecord::Migration[6.1]
  def change
    add_column :workers, :uuid, :string, null:false
  end
end
