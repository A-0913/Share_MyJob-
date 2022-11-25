class Public::MembersController < ApplicationController
  before_action :authenticate_member!, except: [:dummy]
  before_action :block_gusest_member, only: [:update, :withdraw]

    def show
      @member = Member.find(params[:id])
    end

    def edit
      @member = Member.find(params[:id])
    end

    def update
      @member = Member.find(params[:id])
      if @member.update(update_params)
         flash[:notice] = "情報を更新しました"
         redirect_to member_path(@member)
      else
         render :edit
      end
    end

    def member_jobs
      @member = Member.find(params[:id])
      @jobs = @member.jobs.order("created_at DESC").page(params[:page]).per(5)
    end

    def member_themes
      @member = Member.find(params[:id])
      @themes = @member.themes.order("created_at DESC").page(params[:page]).per(5)
    end

    def member_favorites
      @member = Member.find(params[:id])
      favorites= Favorite.where(member_id: @member.id).pluck(:comment_id)
      @favorite_comments = Comment.find(favorites)
    end

    def member_comment_replies
      @member = Member.find(params[:id])
      @comments = @member.comments.where(is_published: true).select { |comment| comment.replies.count > 0 }

    end

    def confirm
      @member = current_member
    end

    def withdraw
      @member = current_member
      # is_deletedカラムをtrueに変更することにより削除フラグを立てる
      @member.update!(is_deleted: true)
      reset_session
      flash[:notice] = "退会処理を実行いたしました"
      redirect_to root_path
    end

    #Deviseを使った新規登録画面で、エラーメッセージが表示されている時にリロードをするとRouting Errorが出てしまう事への対処法
    def dummy
      redirect_to new_member_registration_path
    end

    private
    def update_params
      params.require(:member).permit(:last_name, :first_name, :nickname, :introduction, :belong ,:profile_image, :email, :encrypted_password)
    end
end
