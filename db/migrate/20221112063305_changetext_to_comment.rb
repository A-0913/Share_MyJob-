class ChangetextToComment < ActiveRecord::Migration[6.1]
  def change
    change_column :comments, :comment, :text, null: false
    change_column :comments, :job_id, :integer, null: false
  end
end
