class Admin::ReportsController < ApplicationController

  def index
    @reports = Report.all.order(created_at: :desc).page(params[:page]).per(5)
    @unconfirmed_reports = Report.where(is_checked: false)
  end

  def show
    @report = Report.find(params[:id])
    @reply = @report.reply
    @comment =  @report.comment
    @theme = @comment.theme
    @job = @comment.job
  end

  def edit
    @report = Report.find(params[:id])
  end

  def update
    @report = Report.find(params[:id])
    if @report.update(report_params)
      flash[:notice] = "内容を更新しました。"
      redirect_to admin_report_path(@report)
    end
  end

  def report_params
    params.require(:report).permit(:is_checked)
  end

end
