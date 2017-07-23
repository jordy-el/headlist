class TimelinesController < ApplicationController
  before_action :authenticate_user!

  def show
    redirect_to self_timeline_path if params[:id] == current_user.id.to_s
    @user = self_or_other(params[:id])
    @posts = @user.timeline.posts.order(created_at: :desc)
    @suggested_friends = suggested_friends
  end

  private

  def self_or_other(id)
    id.nil? || id.empty? ? current_user : User.find(id)
  end

  def suggested_friends
    User.where.not(id: current_user.id)
      .where.not(id: @user.id)
      .where.not(id: current_user.friends.map(&:id))
      .where.not(id: current_user.pending_friends.map(&:id))
      .where.not(id: current_user.requested_friends.map(&:id))
      .take(5)
  end
end