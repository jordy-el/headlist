class SettingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
  end

  def update
    @user = current_user
    @user.update_attributes(user_params)
    @user.avatar = avatar_params[:avatar]
    if @user.save!
      redirect_to self_timeline_path
    else
      redirect_to settings_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:date_of_birth, :city)
  end

  def avatar_params
    params.require(:user).permit(:avatar)
  end
end
