class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = current_user
    @likeable = params[:type].classify.constantize.find(params[:id])
    @likeable.liked_by(@user)
    @likeable.save!
    unless @user == @likeable.user
      if @likeable.kind_of? Comment
        Notification.create(
          user: @likeable.user,
          message: "#{current_user.full_name} liked your comment",
          notification_type: :comment_like,
          post: @likeable.post
        )
      else
        Notification.create(
          user: @likeable.user,
          message: "#{current_user.full_name} liked your post",
          notification_type: :post_like,
          post: @likeable
        )
      end
    end
    redirect_to request.referrer
  end

end