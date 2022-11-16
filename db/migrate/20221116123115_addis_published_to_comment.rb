class AddisPublishedToComment < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :is_published, :boolean, null: false, default: false
  end
end
