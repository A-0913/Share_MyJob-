class Public::ThemesController < ApplicationController
before_action :authenticate_any!

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
    @theme = Theme.new(theme_params)
    @theme.member_id = current_member.id
    @job = Job.find(params[:job_id])
    @theme.jobs = [@job]
    if @theme.save
      flash[:notice] = "テーマが申請されました。承認がおりると、テーマ一覧に表示されます。しばらくお待ちください。"
      redirect_to job_path(@job)
    else
      flash[:notice] = "テーマの申請ができませんでした。申請内容をご確認ください。"
      render 'new'
    end
  end

  def dummy
    @job = Job.find(params[:job_id])
    redirect_to new_job_theme_path(@job)
    #Deviseを使った新規登録画面で、エラーメッセージが表示されている時にリロードをするとRouting Errorが出てしまう事への対処法
  end


  private
    def theme_params
      params.require(:theme).permit(:name, :reason )
    end

end
