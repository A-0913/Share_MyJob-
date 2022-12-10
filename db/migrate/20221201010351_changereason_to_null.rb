class ChangereasonToNull < ActiveRecord::Migration[6.1]
  def up
    change_column_null :themes, :reason, true
  end

  def down
    change_column_null :themes, :reason, false
  end
end
