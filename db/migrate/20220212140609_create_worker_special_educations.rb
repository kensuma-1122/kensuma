class CreateWorkerSpecialEducations < ActiveRecord::Migration[6.1]
  def change
    create_table :worker_special_educations do |t|
      t.date :got_on, null: false
      t.json :images
      t.references :worker, foreign_key: true, null: false
      t.references :special_education, foreign_key: true, null: false

      t.timestamps
    end
  end
end
