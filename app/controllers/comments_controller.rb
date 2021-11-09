class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    comment.post_id = @post.id
    comment.save!
    @comments = Comment.all
  end

  def destroy
    @post = Post.find(params[:post_id])
    Comment.find_by(params[:id]).destroy
    @comments = Comment.all
  end

  private
  def comment_params
    params.require(:comment).permit(:text)
  end

end
