class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    comment.post_id = @post.id
    comment.save!
    @comments = @post.comments
  end

  def destroy
    @post = Post.find(params[:post_id])
    Comment.find(params[:id]).destroy
    @comments = @post.comments
  end

  private
  def comment_params
    params.require(:comment).permit(:text)
  end

end
