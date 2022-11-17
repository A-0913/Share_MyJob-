class Public::CommentsController < ApplicationController
before_action :authenticate_any!

  def create
    @job = Job.find(params[:job_id])
    @theme = Theme.find(params[:theme_id])
    @comment = current_member.comments.new(comment_params)
    @comment.job_id = @job.id
    @comment.theme_id = @theme.id
    @comment.member_id = current_member.id
    @comment.save
    #redirect_to job_theme_path(job,theme)
  end

  def destroy
    @job = Job.find(params[:job_id])
    @theme = Theme.find(params[:theme_id])
    @comment = Comment.find(params[:id])

    job = Job.find(params[:job_id])
    @theme = Theme.find(params[:theme_id])
    comment = Comment.find(params[:id])
    comment.update(is_published: false)
    #redirect_to job_theme_path(job,@theme)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end



end
