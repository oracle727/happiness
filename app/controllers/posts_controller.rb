class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @posts = Post.all
    @user = current_user
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    # binding.pry
    if @post.save
    redirect_to post_path(@post)
    flash[:notice] = "投稿しました"
    else
    render:"index"
    end
  end

  def index
    @user = current_user
    @posts = Post.all
    @post = Post.new
  end

  def show
    @newpost = Post.new
    @post = Post.find(params[:id])
    @user = @post.user
    @myuser = current_user
    @comment = Comment.new
    @comments = Comment.all
  end

  def edit
    @post = Post.find(params[:id])
    @user = current_user
    if @user != @post.user
      redirect_to posts_path
    end
  end

  def update
    @user =  current_user
    @post = Post.find(params[:id])
    flash[:notice] = "更新しました"
      if @post.update(post_params)
      redirect_to post_path (@post)
      else
      render:edit
      end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
      redirect_to posts_path
    @user = current_user
    if @user != @post.user
      redirect_to posts_path
    end
  end


  private
  def post_params
      params.require(:post).permit(:title, :explanation, :post_images_images: [])
  end
end
