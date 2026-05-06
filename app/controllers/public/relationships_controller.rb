class Public::RelationshipsController < ApplicationController

    def create
        user = User.find(params[:user_id])
        current_user.follow(user)
        redirect_back(fallback_location: root_url)
    end

    def destroy
        user = User.find(params[:user_id])
        current_user.unfollow(user)
        redirect_back(fallback_location: root_url)
    end
end
