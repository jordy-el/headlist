class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @notifications = current_user.notifications.where(seen: false).order(created_at: :asc)
  end

  def click
    @notification = Notification.find(params[:id])
    @notification.seen = true
    @notification.save!
    case @notification.notification_type.to_sym
    when :friend_request, :friend_accept
      redirect_to self_friends_path
    when :post_reply, :post_like, :timeline_post, :comment_like
      redirect_to post_path(@notification.post)
    else
      redirect_to self_timeline_path
    end
  end

  def delete_all
    current_user.notifications.each(&:destroy)
    redirect_to self_timeline_path
  end
end
