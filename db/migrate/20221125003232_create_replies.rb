class CreateReplies < ActiveRecord::Migration[6.1]
  def change
    create_table :replies do |t|
      t.integer :member_id, null: false
      t.integer :comment_id, null: false
      t.text :reply, null: false
      t.boolean :is_published, default: true, null: false
      t.timestamps
    end
  end
end
