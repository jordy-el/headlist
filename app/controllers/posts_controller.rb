class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @friends = current_user.friends
    @posts = Post.where(user: current_user.friends, timeline: current_user.friends.map(&:timeline))
      .or(Post.where(user: current_user))
    @location = :all
    if params[:filter]
      if params[:filter] == 'photos'
        @posts = @posts.where.not(photo_file_name: nil)
        @location = :photos
      elsif params[:filter] == 'news'
        @posts = @posts.where(photo_file_name: nil)
        @location = :news
      end
    end
    @posts = @posts.page(params[:page]).per(5).order(created_at: :desc)
    @suggested_friends = current_user.suggested_friends
    @comment = Comment.new
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @timeline = @post.timeline
    @suggested_friends = current_user.suggested_friends
    @comment = Comment.new
  rescue ActiveRecord::RecordNotFound
    redirect_to feed_path
  end

  def create
    post_parameters = post_params
    post_parameters[:timeline] = Timeline.find(post_params[:timeline])
    post_parameters[:user] = User.find(post_params[:user])
    @post = Post.new(post_parameters)
    if @post.save!
      @post.timeline.user == current_user || Notification.create(user: @post.timeline.user, message: "#{@post.user.first_name} #{@post.user.last_name} posted on your timeline", notification_type: 'Post')
      redirect_to request.referrer
    else
      redirect_to request.referrer
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy if @post.user == current_user
    redirect_to request.referrer
  end

  private

  def post_params
    params.require(:post).permit(:content, :timeline, :user, :description, :photo)
  end
end