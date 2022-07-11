class CreateFieldWorkers < ActiveRecord::Migration[6.1]
  def change
    create_table :field_workers do |t|
      t.string :admission_worker_name, null: false # 入場する作業員名(作業員名)
      t.date :admission_date_start,    null: false # 入場年月日(始期)
      t.date :admission_date_end,      null: false # 入場年月日(終期)
      t.date :education_date,          null: false # 新規入場時教育(年月日)
      t.references :field_workerable, polymorphic: true

      t.timestamps
    end
  end
end
