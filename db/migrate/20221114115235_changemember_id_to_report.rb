class ChangememberIdToReport < ActiveRecord::Migration[6.1]
  def change
    change_column :reports, :member_id, :integer, null: false
    change_column :reports, :comment_id, :integer, null: false
    change_column :reports, :reason, :string, null: false
    change_column :reports, :is_checked, :boolean, null: false

  end
end
