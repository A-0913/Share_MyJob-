class Admin::ThemesController < ApplicationController
  def index
    @Jobs = Job.all
  end

  def show
    @job = Job.find(params[:id])
    # byebug
    @themes = @job.themes.order("updated_at DESC")
  end

  def edit
    # @theme = Theme.where(job_id: @Job)
  end

  def update
    @theme = Theme.where(job_id: @Job)
    if @theme.update(theme_update_params)
       flash[:notice] = "更新が成功しました!"
       redirect_to admin_theme_path(@theme)
    else
       flash[:notice] = "更新が正常に行われませんでした。内容をご確認ください。"
       render :edit
    end
  end

  private
    def theme_update_params
      params.require(:theme).permit( :name, :reason, :is_published, :is_checked)
    end


end
