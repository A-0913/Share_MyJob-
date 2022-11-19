class AddmemberIdToReport < ActiveRecord::Migration[6.1]
  def change
    add_column :reports, :member_id, :integer
    add_column :reports, :comment_id, :integer
    add_column :reports, :reason, :string
    add_column :reports, :is_checked, :boolean
  end
end
