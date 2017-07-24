class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :addable?

  def addable?
    @user != current_user &&
      !@user.friends_with?(current_user) &&
        !@user.pending_friends.include?(current_user) &&
          !current_user.pending_friends.include?(@user)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :password, :password_confirmation, :first_name, :last_name, :date_of_birth, :city])
  end
end
