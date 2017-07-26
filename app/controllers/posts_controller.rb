class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @friends = current_user.friends
    @posts = Post.where(user: current_user.friends, timeline: current_user.friends.map(&:timeline))
      .or(Post.where(user: current_user))
      .paginate(page: params[:page], per_page: 20)
      .order(created_at: :desc)
    @suggested_friends = current_user.suggested_friends
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @timeline = @post.timeline
    @posts = Post.all.paginate(page: params[:page])
    @suggested_friends = current_user.suggested_friends
  end

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