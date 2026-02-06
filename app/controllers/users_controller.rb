class UsersController < ApplicationController
    
  before_action :authenticate_user!, except: [:show]

    def show
        @user = User.find(params[:id])
        @spots = @user.spots.order(created_at: :desc)
        @liked_spots = @user.likes.order(created_at: :desc).map(&:spot)
    end
    
    def mypage
        @user = current_user
        @spots = @user.spots.order(created_at: :desc)
        @liked_spots = @user.likes.order(created_at: :desc).map(&:spot)
        render :show
    end

end
