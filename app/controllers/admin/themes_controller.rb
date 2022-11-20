class Admin::ThemesController < ApplicationController
  def index
    @jobs = Job.all.page(params[:page]).per(5)
  end

  def show
    @job = Job.find(params[:id])
    @themes = @job.themes.order("updated_at DESC").page(params[:page]).per(5)
  end

  def edit
    @theme = Theme.find(params[:id])
  end

  def update
    @theme = Theme.find(params[:id])
    if @theme.update(theme_update_params)
       flash[:notice] = "更新が成功しました!"
       redirect_to action: :index
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
