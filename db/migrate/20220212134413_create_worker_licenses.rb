class CreateWorkerLicenses < ActiveRecord::Migration[6.1]
  def change
    create_table :worker_licenses do |t|
      t.date :got_on, null: false
      t.json :images
      t.references :worker, foreign_key: true, null: false
      t.references :license, foreign_key: true, null: false

      t.timestamps
    end
  end
end
