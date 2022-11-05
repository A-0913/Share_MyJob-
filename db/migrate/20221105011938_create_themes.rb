class CreateThemes < ActiveRecord::Migration[6.1]
  def change
    create_table :themes do |t|
      t.integer :job_id, null: false
      t.string :name, null: false
      t.string :interest
      t.boolean :is_published, null:false, default:false
      t.boolean :is_checked, null:false, default:false

      t.timestamps
    end
  end
end
