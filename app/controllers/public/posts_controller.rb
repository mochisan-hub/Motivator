class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to root_path
    else 
      render :new
    end
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_comments = @post.post_comments
  end  

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    
  end

  def destroy
    @post = Post.find(params[:id])
    user_id = @post.user_id
    @post.destroy
    redirect_to public_user_path(user_id)
  end

  def search
    @posts = Post.all
    if params[:keyword].present?
      @posts = @posts.joins(:user).where("content LIKE ?", "%#{params[:keyword]}%").or(
      @posts.joins(:user).where("users.name LIKE ?", "%#{params[:keyword]}%"))
    end
  end

  private
  def post_params
    params.require(:post).permit(:image, :content, :start_time, :end_time, training_details_attributes: [:id, :menu_name, :sets, :reps, :_destroy])
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_path unless @post
  end
end
