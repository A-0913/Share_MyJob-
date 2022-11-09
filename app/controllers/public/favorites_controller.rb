class Public::FavoritesController < ApplicationController

  def create
    @job = Job.find(params[:job_id])
    @theme = Theme.find(params[:theme_id])
    @comment = Comment.find(params[:comment_id])
    comment = Comment.find(params[:comment_id])
    favorite = current_member.favorites.new(comment_id: comment.id)
    favorite.save
    #redirect_to request.referer
  end

  def destroy
    @job = Job.find(params[:job_id])
    @theme = Theme.find(params[:theme_id])
    @comment = Comment.find(params[:comment_id])
    comment = Comment.find(params[:comment_id])
    favorite = current_member.favorites.find_by(comment_id: comment.id)
    favorite.destroy
    #redirect_to request.referer
  end


end
