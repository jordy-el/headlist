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
    case @notification.notification_type
    when 'Post'
      redirect_to self_timeline_path
    when 'Friend'
      redirect_to self_friends_path
      else
        redirect_to self_timeline_path
    end
  end

  def delete_all
    current_user.notifications.each(&:destroy)
    redirect_to self_timeline_path
  end
end
