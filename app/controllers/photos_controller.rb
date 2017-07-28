class PhotosController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @photos = @user.posts.select { |p| p.photo.file? }
  end
end
