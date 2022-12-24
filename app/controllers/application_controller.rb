class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :nickname, :introduction, :belong])
  end

  #管理者もしくは会員のどちらかでログインをしていれば移動できるようにする
  def authenticate_any!
    if admin_signed_in?
      true
    else
      authenticate_member!
    end
  end

  #ゲストログインユーザーによる情報の更新を阻止する
  def block_gusest_member
    if admin_signed_in?
      true
    else
      redirect_back(fallback_location: root_path) and return if current_member.guest?
    end
  end

end
