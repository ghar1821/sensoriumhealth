class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  
  before_filter :configure_devise_params, if: :devise_controller?
  # Cleaning up those parameters that are entered by user for sign in and sign up.
  def configure_devise_params
  	devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:firstname, :lastname, :username, :city, :gender, :year_of_birth , :email, :password, :password_confirmation, :terms) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :password, :remember_me) }
  end	

  private

  # Overwriting the sign_in redirect path method
  def after_sign_in_path_for(resource_or_scope)
    current_user
  end



end
