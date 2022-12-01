class AddReplyIdToReport < ActiveRecord::Migration[6.1]
  def change
    add_column :reports, :reply_id, :integer
  end
end
