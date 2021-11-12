class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @post = Post.new
    @posts = @user.posts
    # @post_id = Post.find(user_id])
    @users = User.where.not(id: current_user.id)
     # binding.pry
  end

  def index
    @user = current_user
    @posts = Post.all
    @post = Post.new
    @users = User.not_admin.all
  end

   def followings
    user=User.find(params[:id])
    @users=user.followings
   end

  def followers
    user=User.find(params[:id])
    @users=user.followers
  end

  def create
    @user= User.new(user_params)
    @user.save
     redirect_to user_params_id
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
    redirect_to user_path(current_user)
    end
  end

  def update
    @user= User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "更新しました"
      #binding.pry
    redirect_to user_path (@user)

    else
    render :edit
    end
  end

  def destroy
    if !current_user.is_admin
      @user = current_user
      @posts = Post.all
      @post = Post.new
      @users = User.is_admin.all
      render action: :index
    else
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_path
    end
  end

  def withdraw
    if current_user.is_admin
      @user = User.find(params[:id])
      @user.destroy
      redirect_to users_path
    else
      current_user.destroy
      render "homes/top"
    end
  end


  def withdraw_confirm
    @user = User.find(params[:user][:id])
  end

  def admin
    if current_user.is_admin
       @users =  User.all
    else
     redirect_to root_path
    end
  end

   private
    def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
    end

end
