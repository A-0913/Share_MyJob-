class ChangeisChecdedToReport < ActiveRecord::Migration[6.1]
  def change
    change_column :reports, :is_checked, :boolean, default: false
  end
end
