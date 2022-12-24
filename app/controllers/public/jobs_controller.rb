class Public::JobsController < ApplicationController
  before_action :authenticate_any!
  before_action :block_gusest_member, only: [:new, :create]

  def index
    @genres = Genre.all
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @jobs = @genre.jobs.where(is_published: true).page(params[:page]).per(10)
    else
      @jobs = Job.where(is_published: true).page(params[:page]).per(10)
    end
  end

  def show
    @job = Job.find(params[:id])
    @themes = @job.themes.where(is_published: true).page(params[:page]).per(10)
    @job.update(interest: @job.interest + 1)
  end


  def new
    @job = Job.new
  end

  def create
    @job = current_member.jobs.new(job_params)
    themes = Theme.where(id: [1, 2, 3, 4, 5]) #デフォルトのテーマ5つ分をseedファイルに設定済み
    @job.themes = themes
      if @job.save
        themes.each do |theme|
          theme.save
        end
        redirect_to jobs_path, notice: "職業が申請されました。承認がおりると、職業一覧に表示されます。しばらくお待ちください。"
      else
        render :new
      end
  end

  private

    def job_params
      params.require(:job).permit(:name, :contact, :genre_id )
    end
end
