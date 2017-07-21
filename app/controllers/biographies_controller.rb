class BiographiesController < ApplicationController
  before_action :authenticate_user!

  def show
    redirect_to self_biography_path if params[:id] == current_user.id.to_s
    @user = params[:id].nil? || params[:id].empty? ? current_user : User.find(params[:id])
    @biography = @user.biography
  end

  def edit
    redirect_to self_timeline_path if params[:id] != current_user.id.to_s
    @user = current_user
    @biography = current_user.biography
  end

  def update
    @user = current_user
    @biography = @user.biography
    @biography.update!(biography_params)
    redirect_to self_biography_path
  end

  private

  def biography_params
    params.require(:biography).permit(:location, :hometown, :workplace, :school, :website, :github)
  end
end
