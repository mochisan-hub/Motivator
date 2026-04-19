class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @user = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to public_user_path(@user), notice: "更新しました"
    else
      render "public/users/edit"
    end
  end 

  def destroy
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_statement, :profile_images)
  end

  def correct_user
    @user = User.find_by_id(params[:id])
    if !(@user && @user == current_user)
      redirect_to root_path
    end
  end
end
