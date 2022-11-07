class RemoveInterestFromTheme < ActiveRecord::Migration[6.1]
  def change
    remove_column :themes, :interest ,:integer
  end
end
