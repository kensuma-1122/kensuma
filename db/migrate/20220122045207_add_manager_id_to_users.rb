class AddManagerIdToUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :admin_user
  end
end
