class RenameReasonColumnToJobs < ActiveRecord::Migration[6.1]
  def change
    rename_column :jobs, :reason, :contact
  end
end
