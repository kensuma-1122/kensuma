class AddAdimnToUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :admin, foreign_key: { to_table: :users }
  end
end
