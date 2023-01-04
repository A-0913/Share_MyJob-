class Public::MembersController < ApplicationController
  before_action :authenticate_member!, except: %i(dummy)
  before_action :ensure_user!, except: %i(show confirm withdraw dummy)
  before_action :block_gusest_member, only: %i(edit update confirm withdraw)

  def show
    @member = Member.find(params[:id])
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])

    update_params = params[:member][:password].blank? ? update_without_password_params : update_with_password_params

    if @member.update(update_params)
      redirect_to member_path(@member), notice: "情報を更新しました"
    else
      render :edit
    end
  end

  def member_jobs
    @jobs = current_member.jobs.order("created_at DESC").page(params[:page]).per(5)
  end

  def member_themes
    @themes = current_member.themes.order("created_at DESC").page(params[:page]).per(5)
  end

  def member_favorites
    favorites= Favorite.where(member_id: current_member.id).pluck(:comment_id)
    @favorite_comments = Comment.find(favorites)
  end

  def member_comment_replies
    @comments = current_member.comments.where(is_published: true).select { |comment| comment.replies.count > 0  && comment.replies.last.member != current_member}
  end

  def confirm
  end

  def withdraw
    member = current_member
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    member.update!(is_deleted: true)
    reset_session
    redirect_to root_path, notice: "退会処理を実行いたしました"
  end

  #Deviseを使った新規登録画面で、エラーメッセージが表示されている時にリロードをするとRouting Errorが出てしまう事への対処法
  def dummy
    redirect_to new_member_registration_path
  end

  private

  def update_with_password_params
    params.require(:member).permit(:last_name, :first_name, :nickname, :introduction, :belong ,:profile_image, :email, :password)
  end

  def update_without_password_params
    params.require(:member).permit(:last_name, :first_name, :nickname, :introduction, :belong ,:profile_image, :email)
  end

  def ensure_user!
    redirect_to root_path, alert: "不正なアクセスです" unless params[:id].to_i == current_member.id
    #params[:id]で取得できる値は文字列であり、数値であるcurrent_user.idと比較してもfalseとなるため、「.to_i」をつける
  end
end
