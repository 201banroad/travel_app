class UsersController < ApplicationController
    
  before_action :authenticate_user!, except: [:show]

    def show
        @user = User.find(params[:id])
        @spots = @user.spots.order(created_at: :desc)
    end
    
    def mypage
        @user = current_user
        @spots = @user.spots.order(created_at: :desc)
        render :show
    end

end
