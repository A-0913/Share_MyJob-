class Public::ThemesController < ApplicationController
before_action :authenticate_any!
before_action :block_gusest_member, only: %i(new create)

  def show
    @job = Job.find(params[:job_id])
    @theme = @job.themes.find(params[:id])
    @theme_job = ThemeInJob.find_by(job_id: @job.id, themes: @theme.id)
    @theme_job.update(interest: @theme_job.interest + 1 ) if params[:page].nil?
    @comment = Comment.new
    @comments = Comment.where(theme_id: @theme.id).where(job_id: @job.id).where(is_published: true).order(created_at: :desc).page(params[:page]).per(7)
  end

  def new
    @job = Job.find(params[:job_id])
    @theme = Theme.new
  end

  def create
    @theme = current_member.themes.new(theme_params)
    @job = Job.find(params[:job_id])
    @theme.jobs = [@job]
    if @theme.save
      redirect_to job_path(@job), notice: "テーマが申請されました。承認がおりると、テーマ一覧に表示されます。しばらくお待ちください。"
    else
      render :new
    end
  end

  #テーマ投稿画面で、エラーメッセージが表示されている時にリロードをするとRouting Errorが出てしまう事への対処
  def dummy
    redirect_to new_job_theme_path(params[:job_id])
  end


  private
    def theme_params
      params.require(:theme).permit(:name, :contact )
    end

end
