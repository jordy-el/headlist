class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    comment_parameters = comment_params
    comment_parameters[:post] = Post.find(comment_params[:post].to_i)
    @comment = Comment.new(comment_parameters)
    @comment.user = current_user
    if @comment.save!
      redirect_to post_path(@comment.post)
    else
      redirect_to feed_path
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    redirect_to feed_path if @comment.user != current_user
    @comment.destroy
    redirect_to post_path(@comment.post)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post)
  end
end
