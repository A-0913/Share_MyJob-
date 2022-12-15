class Public::FavoritesController < ApplicationController
  before_action :block_gusest_member

  def create
    set_comment
    favorite = current_member.favorites.new(comment_id: @comment.id)
    favorite.save
  end

  def destroy
    set_comment
    favorite = current_member.favorites.find_by(comment_id: @comment.id)
    favorite.destroy
  end


end
