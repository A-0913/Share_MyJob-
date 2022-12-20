class Admin::ReportsController < Admin::AdminController

  def index
    @reports = Report.all.order(created_at: :desc).page(params[:page]).per(5)
    @unconfirmed_reports = Report.where(is_checked: false)
  end

  def show
    @report = Report.find(params[:id])
  end

  def edit
    @report = Report.find(params[:id])
  end

  def update
    @report = Report.find(params[:id])
    if @report.update(report_params)
      redirect_to admin_report_path(@report), notice: "内容を更新しました。"
    else
      render :edit
    end
  end

  def report_params
    params.require(:report).permit(:is_checked)
  end

end
