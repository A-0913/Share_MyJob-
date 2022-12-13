class Public::FavoritesController < ApplicationController
  before_action :block_gusest_member

  def create
    @job = Job.find(params[:job_id])
    @theme = Theme.find(params[:theme_id])
    @comment = Comment.find(params[:comment_id])
    favorite = current_member.favorites.new(comment_id: @comment.id)
    favorite.save
  end

  def destroy
    @job = Job.find(params[:job_id])
    @theme = Theme.find(params[:theme_id])
    @comment = Comment.find(params[:comment_id])
    favorite = current_member.favorites.find_by(comment_id: @comment.id)
    favorite.destroy
  end


end
