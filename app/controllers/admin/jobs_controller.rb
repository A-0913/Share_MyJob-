class Admin::JobsController < ApplicationController

  def index
    @jobs = Job.all.order(created_at: :desc)
  end

  def show
    @job = Job.find(params[:id])
  end

  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    if @job.update(job_update_params)
       flash[:notice] = "更新が成功しました!"
       redirect_to admin_job_path(@job)
    else
       flash[:notice] = "更新が正常に行われませんでした。内容をご確認ください。"
       render :edit
    end
  end

  private
    def job_update_params
      params.require(:job).permit(:genre_id, :name, :reason, :is_published, :is_checked)
    end

end
