class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :provder, :uid, :password, :current_password) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :email, :password, :current_password) }
  end
  
  private

  def current_account
    Account.find_by_owner_id(current_user.id)
  end
  helper_method :current_account
  
  def verify_account
    if !current_account
      flash[:alert] = "You must create or be added to an account to access this page."
      redirect_to root_path
    end
  end
  
end
