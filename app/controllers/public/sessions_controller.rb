# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # 会員の論理削除のための記述。退会後は、同じアカウントでは利用できない。
  def reject_member
    @member = Member.find_by(email: params[:member][:email])
    if @member
      if @member.valid_password?(params[:member][:password]) && (@member.is_deleted == true)
        flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
        redirect_to new_member_session_path
      end
    end
  end

  def new_guest
    member = Member.guest
    sign_in member   # ユーザーをログインさせる
    redirect_to jobs_path, notice: 'ゲストとしてログインしました。'
  end

  def after_sign_in_path_for(resource)
    jobs_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end



  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
