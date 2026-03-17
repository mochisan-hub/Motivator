class Public::PostsController < ApplicationController
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
    @posts = Post.order(created_at: :desc)
  end

  private
  def post_params
    params.require(:post).permit(:image, :content, :start_time, :end_time, training_details_attributes: [:id, :menu_name, :sets, :reps, :_destroy])
  end


end
