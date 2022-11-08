class AddJobIdToComment < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :job_id, :integer
  end
end
