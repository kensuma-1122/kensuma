class CreateWorkerSpecialEducations < ActiveRecord::Migration[6.1]
  def change
    create_table :worker_special_educations do |t|
      t.date :got_on, null: false
      t.json :images
      t.references :worker, foreign_key: true, null: false
      t.references :special_education, foreign_key: { to_table: :worker_special_educations }, null: false

      t.timestamps
    end
    add_index :worker_special_educations, [:worker_id, :special_education_id], unique: true, name: 'worker_special_educations_index'
  end
end
