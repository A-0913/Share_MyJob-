class AddInterestToThemes < ActiveRecord::Migration[6.1]
  def change
    add_column :theme_in_jobs, :interest, :integer, default: 0, null: false
  end
end
