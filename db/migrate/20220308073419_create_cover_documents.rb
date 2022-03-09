class CreateCoverDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :cover_documents do |t|
      t.references :document, null: false, foreign_key: true
      t.string :business_name
      t.date :submitted_on

      t.timestamps
    end
  end
end
