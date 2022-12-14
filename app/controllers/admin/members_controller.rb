class Admin::MembersController < Admin::AdminController

  def index
    @members = Member.page(params[:page]).per(5)
  end

  def show
    @member = Member.find(params[:id])
  end


  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
      if @member.update(update_admin_params)
        redirect_to admin_member_path(@member), notice: "更新を完了しました!"
      else
        flash[:notice] = "更新が正常に行われませんでした。内容をご確認ください。"
        render :edit
      end
  end

  def member_jobs
    @member = Member.find(params[:id])
    @jobs = @member.jobs.order("created_at DESC").page(params[:page]).per(10)
  end

  def member_themes
    @member = Member.find(params[:id])
    @themes = @member.themes.order("created_at DESC").page(params[:page]).per(10)
  end

  private
    def update_admin_params
      params.require(:member).permit(:last_name, :first_name, :nickname, :email, :introduction, :belong, :is_deleted, :profile_image)
    end

end
