class Admin::ThemesController < Admin::AdminController

  def theme_in_job
    @job = Job.find(params[:job_id])
    @themes = @job.themes.order("updated_at DESC").page(params[:page]).per(5)
  end

  def index
    @jobs = Job.all.page(params[:page]).per(5)
  end

  def edit
    @job = Job.find(params[:job_id])
    @theme = Theme.find(params[:id])
  end

  def update
    @job = Job.find(params[:job_id])
    @theme = Theme.find(params[:id])
    if @theme.update(theme_update_params)
      redirect_to edit_admin_job_theme_path(@job, @theme), notice: "更新が成功しました!"
    else
      flash[:notice] = "更新が正常に行われませんでした。内容をご確認ください。"
      render :edit
    end
  end

  #テーマ編集画面で、エラーメッセージが表示されている時にリロードをするとRouting Errorが出てしまう事への対処
  def dummy
    redirect_to edit_admin_job_theme_path(params[:job_id], params[:id] )
  end

  private
    def theme_update_params
      params.require(:theme).permit( :name, :contact, :is_published, :is_checked)
    end

end
