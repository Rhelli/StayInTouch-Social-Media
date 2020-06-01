class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery with: :exception

  before_action :friendship_conditionals, if: :user_logged_in
  before_action :configure_permitted_parameters, if: :devise_controller?

  def friendship_conditionals
    suggested_friends = User.non_friends(current_user).dup
    @non_friends = suggested_friends
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password) }
  end

  private

  def user_logged_in
    !current_user.nil?
  end
end
