class Public::CommentsController < ApplicationController
before_action :authenticate_member!

  def create
    job = Job.find(params[:job_id])
    # theme = findjob.themes．＿by（params（：id］）
    theme = Theme.find(params[:theme_id])
    comment = current_member.comments.new(comment_params)
    comment.job_id = job.id
    comment.theme_id = theme.id
    comment.member_id = current_member.id
    #binding.pry
    comment.save
    redirect_to job_theme_path(job,theme)
  end

  def destroy
    job = Job.find(params[:job_id])
    @theme = Theme.find(params[:theme_id])
    #binding.pry
    comment = Comment.find(params[:id])#ここが問題
    comment.destroy
    redirect_to job_theme_path(job,@theme)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
