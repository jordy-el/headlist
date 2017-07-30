class FriendsController < ApplicationController
  before_action :authenticate_user!

  def show
    redirect_to self_friends_path if params[:id] == current_user.id.to_s
    @user = params[:id].nil? || params[:id].empty? ? current_user : User.find(params[:id])
    @friends = @user.friends
    @requests = @user.requested_friends
    @pending = @user.pending_friends
  end

  def accept
    @requester = User.find(params[:id])
    current_user.accept_request(@requester)
    redirect_to self_friends_path
  end

  def decline
    @requester = User.find(params[:id])
    current_user.decline_request(@requester)
    redirect_to self_friends_path
  end

  def create
    @user = User.find(params[:id])
    redirect_to self_timeline_path if @user == current_user
    current_user.friend_request(@user)
    Notification.create(
        user: @user,
        message: "#{@user.full_name} sent you a friend request",
        notification_type: 'Friend Request'
    )
    redirect_to self_timeline_path
  end
end
