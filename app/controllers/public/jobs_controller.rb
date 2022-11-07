class Public::JobsController < ApplicationController
  before_action :authenticate_member!

  def index
    @jobs = Job.where(is_published: true)
    @member = current_member
  end

  def show
    @job = Job.find(params[:id])
    @themes = @job.themes.where(is_published: true)
    @job.update(interest: @job.interest + 1)
    @member = current_member
  end


  def new
  end

  def create
    @job = Job.new(job_params)
    @job.member_id = current_member.id
    @themes = Theme.where(id: [1, 2, 3, 4, 5])
    @job.themes = @themes
      if @job.save!
        @themes.each do |theme|
          theme.save!
        end
        flash[:notice] = "職業が申請されました。承認がおりると、職業一覧に表示されます。しばらくお待ちください。"
        redirect_to jobs_path
      else
      byebug
        flash[:notice] = "職業の申請ができませんでした。申請内容をご確認ください。"
        render 'new'
      end
  end

  private
    def job_params
      params.permit(:name, :reason, :genre_id )
    end

end
