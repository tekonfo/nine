class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
    before_action :configure_permitted_parameters, if: :devise_controller?
  def after_sign_out_path_for(resource)
    new_user_session_path
  end


  protected

##deviseに登録するカラムを追加している。今回はnameカラムを追加している。
  def configure_permitted_parameters
    added_attrs = [ :name, :email, :password, :password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end
end
