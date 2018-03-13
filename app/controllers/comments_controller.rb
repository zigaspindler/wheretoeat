class CommentsController < ApplicationController

  def new
    @comment = Comment.new
    @comment.user = current_user
    @comment.group = current_group
    @comment.vote = current_user.my_vote
  end

  def edit
    @comment = Comment.find params[:id]
  end

  def create
    comment = Comment.new comment_params
    comment.user = current_user
    comment.group = current_group
    comment.save
    redirect_to dashboard_index_path
  end

  def update
    comment = Comment.find params[:id]
    comment.update comment_update_params
    comment.save
    redirect_to root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :vote_id)
  end

  def comment_update_params
    params.require(:comment).permit(:text)
  end
end
