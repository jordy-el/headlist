class HomeController < ApplicationController
  def index
    redirect_to self_timeline_path if user_signed_in?
    @user = User.new
  end
end
