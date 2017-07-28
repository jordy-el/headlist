class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = current_user
    @likeable = params[:type].classify.constantize.find(params[:id])
    @likeable.liked_by(@user)
    @likeable.save!
    redirect_to request.referrer
  end

end