class Admin::HomesController < Admin::AdminController

  def top
    @unconfirmed_jobs = Job.where(is_checked: false)
    @jobs = Job.all
    @unconfirmed_reports = Report.where(is_checked: false)
  end

end
