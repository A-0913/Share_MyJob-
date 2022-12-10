class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_admin!, if: :admin_url

  #管理者ログインをしないと管理者関連ページに移動できないようにする
  def admin_url
    request.fullpath.include?("/admin")
  end



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
      redirect_back(fallback_location: root_path) and return if current_member.email == 'guest@example.com'
    end
  end

  def set_comment
    @job = Job.find(params[:job_id])
    @theme = Theme.find(params[:theme_id])
    @comment = Comment.find(params[:comment_id])
  end

end
