class Public::ReportsController < ApplicationController
  def new
    @job = Job.find(params[:job_id])
    @theme = Theme.find(params[:theme_id])
    @comment = Comment.find(params[:comment_id])
    @report = Report.new
  end

  def create
    @comment = Comment.find(params[:comment_id])
    @report = Report.new(report_params)
    @report.member_id = current_member.id
    @report.comment = Comment.find(params[:comment_id])
    # binding.pry
    if @report.save
      flash[:notice] = "通報を受け付けました。ご報告ありがとうございました。"
      redirect_to request.referer
    else
      @job = Job.find(params[:job_id])
      @theme = Theme.find(params[:theme_id])
      @comment = Comment.find(params[:comment_id])
      render "new"
    end
  end

  private

  def report_params
    params.require(:report).permit(:reason)
  end


end
