class HomeController < ApplicationController
  def index
    # redirect_to user_url(current_user) if user_signed_in?
    @user = User.new
  end
end
