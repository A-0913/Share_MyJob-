class ChangeCommentToIsPublished < ActiveRecord::Migration[6.1]
  def change
    change_column_default(:comments, :is_published, from: false , to: true)
  end
end
