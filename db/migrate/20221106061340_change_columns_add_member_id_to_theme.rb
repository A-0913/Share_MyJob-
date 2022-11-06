class ChangeColumnsAddMemberIdToTheme < ActiveRecord::Migration[6.1]
  def change
    change_column_null :themes, :member_id, false
  end
end
