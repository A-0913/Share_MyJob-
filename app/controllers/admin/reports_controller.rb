class Admin::ReportsController < ApplicationController

  def index
    @reports = Report.all.order(created_at: :desc)
  end

  def show
    @report = Report.find(params[:id])
    @comment =  @report.comment
    @theme = @comment.theme
    @job = @theme.job
  end

  def edit
    @report = Report.find(params[:id])
  end

  def update
    @report = Report.find(params[:id])
    if @report.update(report_params)
      flash[:notice] = "内容をを更新しました。"
      redirect_to request.referer
    end
  end

  def report_params
    params.require(:report).permit(:is_checked)
  end

end
