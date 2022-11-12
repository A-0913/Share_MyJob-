class ChangeCloumnsNotnullAddComments < ActiveRecord::Migration[6.1]
  def change
    change_column :comments, :member_id, :integer, null: false
    change_column :comments, :theme_id, :integer, null: false
  end
end
