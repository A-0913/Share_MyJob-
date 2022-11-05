class CreateThemes < ActiveRecord::Migration[6.1]
  def change
    create_table :themes do |t|
      t.integer :job_id
      t.string :name, null: false
      t.integer :interest
      t.boolean :is_published, null:false, default:false
      t.boolean :is_checked, null:false, default:false

      t.timestamps
    end
  end
end
