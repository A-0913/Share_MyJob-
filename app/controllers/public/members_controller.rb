class Public::MembersController < ApplicationController
  def show
    @member = Member.find(params[:id])
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(update_params)
       flash[:notice] = "更新が成功しました!"
       redirect_to member_path(@member)
    else
       render :show
    end
  end

  def confirm
  end

  def withdraw
    @member = current_member
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @member.update!(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private
    def update_params
      params.require(:member).permit(:last_name, :first_name, :nickname, :introduction, :belong ,:profile_image, :email)
    end
end
