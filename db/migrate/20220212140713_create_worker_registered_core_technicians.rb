class CreateWorkerRegisteredCoreTechnicians < ActiveRecord::Migration[6.1]
  def change
    create_table :worker_registered_core_technicians do |t|
      t.date :got_on, null: false
      t.json :images
      t.references :worker, foreign_key: true, null: false
      t.references :core_technician, foreign_key: { to_table: :worker_registered_core_technicians }, null: false

      t.timestamps
    end
  end
end
