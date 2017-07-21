class PostsController < ApplicationController
  before_action :authenticate_user!

  def create
    post_parameters = post_params
    post_parameters[:timeline] = Timeline.find(post_params[:timeline])
    post_parameters[:user] = User.find(post_params[:user])
    @post = Post.new(post_parameters)
    if @post.save!
      @post.timeline.user == current_user || Notification.create(user: @post.timeline.user, message: "#{@post.user.first_name} #{@post.user.last_name} posted on your timeline", notification_type: "Post")
      redirect_to timeline_path(@post.timeline.user)
    else
      redirect_to :back
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :timeline, :user)
  end
end