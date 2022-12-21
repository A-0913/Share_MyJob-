class Public::RepliesController < ApplicationController
before_action :authenticate_any!
before_action :block_gusest_member, only: [:new, :create, :destroy]

  def index
    @comment = Comment.find(params[:comment_id])
    @replies = @comment.replies.where(is_published: true)
  end

  def new
    @comment = Comment.find(params[:comment_id])
    @reply = Reply.new
  end

  def create
    set_comment
    #@comment = Comment.find(params[:comment_id])
    @reply = current_member.replies.new(reply_params)
    @reply.comment_id = @comment.id
    if @reply.save
      redirect_to job_theme_comment_replies_path(@job, @theme, @comment), notice: "返信コメントを送信しました！"
      #redirect_to job_theme_comment_replies_path(@comment.job, @comment.theme, @comment), notice: "返信コメントを送信しました！"
    else
      render :new
    end
  end

  def destroy
    set_comment
    #@comment = Comment.find(params[:comment_id])
    reply = Reply.find(params[:id])
    reply.update(is_published: false)
    #is_publishedカラムをfalseに変更することにより返信を非表示にする
    redirect_to job_theme_comment_replies_path(@job, @theme, @comment)
    #redirect_to job_theme_comment_replies_path(@comment.job, @comment.theme, @comment), notice: "返信コメントを送信しました！"
  end

  private
  def reply_params
    params.require(:reply).permit(:reply)
  end
end
