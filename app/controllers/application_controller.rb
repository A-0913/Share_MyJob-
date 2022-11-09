class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_admin!, if: :admin_url

  def admin_url
    request.fullpath.include?("/admin")
  end



  protected

  def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :nickname, :introduction, :belong])
  end

  def authenticate_any!
    if admin_signed_in?
        true
    else
        authenticate_member!
    end
  end


end
