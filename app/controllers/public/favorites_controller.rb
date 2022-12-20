class Public::FavoritesController < ApplicationController
  before_action :block_gusest_member

  def create
    @comment = Comment.find(params[:comment_id])
    current_member.favorites.create(comment_id: @comment.id)
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    current_member.favorites.find_by(comment_id: @comment.id).destroy
  end


end
