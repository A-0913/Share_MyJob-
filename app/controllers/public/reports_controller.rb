class Public::ReportsController < ApplicationController
  before_action :authenticate_member!
  before_action :block_gusest_member, only: [:new, :create]

  def new
    @comment = Comment.find(params[:comment_id])
    @reply = Reply.find(params[:reply_id]) if params[:reply_id]
    @report = Report.new
  end

  def create
    @comment = Comment.find(params[:comment_id])
    @reply = Reply.find(params[:reply_id]) if params[:reply_id]
    @report = current_member.reports.new(report_params)
    @report.comment = @comment
    @report.reply_id = @reply.id if params[:reply_id]
    if @report.save!
      flash[:notice] = "通報を受け付けました。ご報告ありがとうございました。"
      if params[:reply_id]
        redirect_to job_theme_comment_replies_path(@comment.job, @comment.theme, @comment)
      else
        redirect_to job_theme_path(@comment.job, @comment.theme)
      end
    else
      render :new
    end
  end

  private

  def report_params
    params.require(:report).permit(:reason)
  end
end
