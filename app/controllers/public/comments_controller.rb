class Public::CommentsController < ApplicationController

  def create
    job = Job.find(params[:job_id])
    theme = job.themes.find_by(params[:id])
    comment = current_member.comments.new(comment_params)
    comment.theme_id = theme.id
    comment.member_id = current_member.id
    comment.save
    redirect_to job_theme_path(job,theme)
  end

  def destroy
    job = Job.find(params[:job_id])
    @theme = job.themes.find_by(params[:id])
    comment = Comment.find_by(theme_id: @theme.id, id: comment_id )#ここが問題
    comment.destroy
    redirect_to job_theme_path(job,theme)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
