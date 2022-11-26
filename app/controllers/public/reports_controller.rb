class Public::ReportsController < ApplicationController
  before_action :authenticate_member!
  before_action :block_gusest_member, only: [:create]

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
    @report.comment = @comment
    if @report.save
      @theme = @comment.theme
      @job = Job.find(params[:job_id])
      flash[:notice] = "通報を受け付けました。ご報告ありがとうございました。"
      redirect_to job_theme_path(@job,@theme)
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
