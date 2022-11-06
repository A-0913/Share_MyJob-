class CreateThemeInJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :theme_in_jobs do |t|
      t.integer :job_id, null: false
      t.integer :theme_id, null: false

      t.timestamps
    end
  end
end
