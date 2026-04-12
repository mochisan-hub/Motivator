class Public::FavoritesController < ApplicationController

  def index
    favorites = Favorite.where(user_id: current_user.id).pluck(:post_id)
    @favorite_posts = Post.where(id: favorites)
  end

  def create
    post = Post.find(params[:post_id])
    current_user.favorites.find_or_create_by(post_id: post.id)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    post = Post.find(params[:post_id])
    current_user.favorites.find_by(post_id: post.id)&.destroy
    redirect_back(fallback_location: root_path)
  end

end
