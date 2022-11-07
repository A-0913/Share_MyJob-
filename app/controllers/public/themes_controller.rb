class Public::ThemesController < ApplicationController
before_action :authenticate_member!

  def show
    @job = Job.find(params[:job_id])
    @theme = @job.themes.find(params[:id])
    @theme.update(interest: @theme.interest + 1)
    #@comment = Comment.new
  end

  def new
    @job = Job.find(params[:job_id])
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

  private
    def theme_params
      params.permit(:name, :reason )
    end

end
