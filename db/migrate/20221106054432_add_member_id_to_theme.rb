class AddMemberIdToTheme < ActiveRecord::Migration[6.1]
  def change
    add_column :themes, :member_id, :integer
  end
end
