class CreateDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :documents do |t|
      t.integer :type
      t.date :created_on
      t.date :submitted_on

      t.timestamps
    end
  end
end
