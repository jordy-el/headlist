class PhotosController < ApplicationController
  before_action :authenticate_user!

  def show
    redirect_to self_photos_path if current_user.id.to_s == params[:id]
    @user = params[:id].nil? ? current_user : User.find(params[:id])
    @photos = @user.posts.where.not(photo_file_name: nil)
  end
end
