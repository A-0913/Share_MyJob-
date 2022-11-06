class RemoveJobIdFromThemes < ActiveRecord::Migration[6.1]
  def change
    remove_column :themes, :job_id, :integer
  end
end
