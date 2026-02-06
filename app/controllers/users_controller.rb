class UsersController < ApplicationController
    
  before_action :authenticate_user!, except: [:show]

    def show
        @user = User.find(params[:id])
        @spots = @user.spots
    end
    
    def mypage
        @user = current_user
        @spots = @user.spots
        render :show
    end

end
