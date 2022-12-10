class RenameReasonColumnToThemes < ActiveRecord::Migration[6.1]
  def change
    rename_column :themes, :reason, :contact
  end
end
