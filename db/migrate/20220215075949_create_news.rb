class CreateNews < ActiveRecord::Migration[6.1]
  def change
    create_table :news do |t|
      t.string :title, null: false, default: ''
      t.text :content
      t.datetime :delivered_at
      t.integer :status, null: false, default: 0 # modelにenumを定義

      t.timestamps
    end
  end
end
