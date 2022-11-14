class Public::ReportsController < ApplicationController
  def new
    @job = Job.find(params[:job_id])
    @theme = Theme.find(params[:theme_id])
    @comment = Comment.find(params[:comment_id])
  end

  def create
    @report = Report.new(report_params)
    @report.member_id = current_member.id
    @report.comment_id = Comment.find(params[:comment_id])
    @comment = Comment.find(params[:comment_id])
    if @report.save
      flash[:notice] = "通報を受け付けました。ご報告ありがとうございました。"
      redirect_to request.referer
    else
      render "new"
    end
  end

  private

  def report_params
    params.require(:report).permit(:reason)
  end


end
