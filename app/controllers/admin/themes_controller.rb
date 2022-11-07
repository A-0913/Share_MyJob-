class Admin::ThemesController < ApplicationController
  def index
    @Jobs = Job.all
  end

  def show
    @Job = Job.find(params[:id])
    # @themes = @job.themes.all
    # @theme = Theme.where(job_id: @Job)
  end
  
  def edit
    # @theme = Theme.where(job_id: @Job)
  end
  
  
end
