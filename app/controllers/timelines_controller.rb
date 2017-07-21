class TimelinesController < ApplicationController
  before_action :authenticate_user!

  def show
    redirect_to self_timeline_path if params[:id] == current_user.id.to_s
    @user = params[:id].nil? || params[:id].empty? ? current_user : User.find(params[:id])
    @posts = @user.timeline.posts.order(created_at: :desc)
  end
end