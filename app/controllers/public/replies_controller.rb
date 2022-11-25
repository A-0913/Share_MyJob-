class Public::RepliesController < ApplicationController
  
  def index
    @job = Job.find(params[:job_id])
    @theme = Theme.find(params[:theme_id])
    @comment = Comment.find(params[:comment_id])
    @replys = Reply.where(is_published: true)
  end

  def new
    @reply = Reply.new
  end
  
  
  
end
