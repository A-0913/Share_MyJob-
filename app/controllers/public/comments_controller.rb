class Public::CommentsController < ApplicationController
  before_action :block_gusest_member

  def create
    comment = current_member.comments.new(comment_params)
    comment.job_id = params[:job_id]
    comment.theme_id = params[:theme_id]

    if comment.save
      @comments = Comment.where(theme_id: params[:theme_id], job_id: params[:job_id], is_published: true).order(created_at: :desc).page(params[:page]).per(7)
      render :create
    else
      @comment = comment
      render :error
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.update(is_published: false)
    #↑is_publishedカラムをfalseに変更することによりコメントを非表示にする
    @comments = Comment.where(theme_id: params[:theme_id], job_id: params[:job_id], is_published: true).order(created_at: :desc).page(params[:page]).per(7)
    render :destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
