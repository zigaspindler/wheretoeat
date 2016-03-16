class CommentsController < ApplicationController
  def create
    comment = Comment.new comment_params
    comment.user = current_user
    comment.group = current_group
    comment.save
    redirect_to dashboard_index_path
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
