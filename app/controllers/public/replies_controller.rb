class Public::RepliesController < ApplicationController
before_action :authenticate_any!
before_action :block_gusest_member, only: [:create, :destroy]

  def index
    set_comment
    @replies = @comment.replies.where(is_published: true)
  end

  def new
    set_comment
    @reply = Reply.new
  end

  def create
    set_comment
    @reply = current_member.replies.new(reply_params)
    #@reply.member_id = current_member.id
    @reply.comment_id = @comment.id
    if @reply.save
      flash[:notice] = "返信コメントを送信しました！"
      redirect_to job_theme_comment_replies_path(@job,@theme,@comment)
    else
      render :new
    end
  end

  def destroy
    set_comment
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
