class AddJobTitleToWorkers < ActiveRecord::Migration[6.1]
  def change
    add_column :workers, :job_title, :string, null: false
  end
end
