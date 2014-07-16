class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    #will figure out strong parameters later
    # devise_parameter_sanitizer.for(:sign_up).permit(:avatar, :first_name, :last_name, :provider, :uid)
    # devise_parameter_sanitizer.for(:account_update).permit(:avatar, :first_name, :last_name)
    # << :avatar << :name << :nickname << :provider << :uid
    # devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:avatar, :name, :nickname, :provider, :uid)}
    #<< :avatar << :name << :nickname
    # devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:avatar, :name, :nickname)}
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:nickname, :email, :password, :password_confirmation, :remember_me, :avatar, :name) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :nickname, :email, :password, :remember_me, :avatar, :name) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:nickname, :email, :password, :password_confirmation, :current_password, :avatar, :name) }
  end
end
