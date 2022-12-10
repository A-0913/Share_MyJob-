class ChangeColumnToNull < ActiveRecord::Migration[6.1]
  def up
    change_column_null :jobs, :reason, true
  end

  def down
    change_column_null :jobs, :reason, false
  end
end
