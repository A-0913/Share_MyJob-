class Public::RepliesController < ApplicationController
before_action :authenticate_any!
before_action :block_gusest_member

  def index
    @job = Job.find(params[:job_id])
    @theme = Theme.find(params[:theme_id])
    @comment = Comment.find(params[:comment_id])
    @replies = Reply.where(is_published: true)
  end

  def new
    @job = Job.find(params[:job_id])
    @theme = Theme.find(params[:theme_id])
    @comment = Comment.find(params[:comment_id])
    @reply = Reply.new
  end

  def create
    job = Job.find(params[:job_id])
    theme = Theme.find(params[:theme_id])
    comment = Comment.find(params[:comment_id])
    reply = current_member.replies.new(reply_params)
    reply.member_id = current_member.id
    reply.comment_id = comment.id
    if reply.save
      flash[:notice] = "返信コメントを送信しました！"
      redirect_to job_theme_comment_replies_path(job,theme,comment)
    else
      render 'new'
    end
  end

  def destroy
    @job = Job.find(params[:job_id])
    @theme = Theme.find(params[:theme_id])
    @comment = Comment.find(params[:comment_id])
    reply = Reply.find(params[:id])
    reply.update(is_published: false)
    #is_publishedカラムをfalseに変更することにより返信を非表示にする
    redirect_to job_theme_comment_replies_path(@job,@theme,@comment)
  end

  private
  def reply_params
    params.require(:reply).permit(:reply)
  end

end
