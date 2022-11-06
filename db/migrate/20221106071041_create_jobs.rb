class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs do |t|
      t.integer :member_id, null: false
      t.integer :genre_id, null: false
      t.string :name, null: false
      t.string :reason, null: false
      t.integer :interest, null: false, default:0
      t.boolean :is_published, null:false, default:false
      t.boolean :is_checked, null:false, default:false

      t.timestamps
    end
  end
end
