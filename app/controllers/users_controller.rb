class UsersController < ApplicationController
    
  before_action :authenticate_user!, except: [:show]

    def show
        @user = User.find(params[:id])
        @spots = @user.spots  # このログイン中ユーザーの投稿をまとめて@spotsに入れる
        @liked_spots = @user.liked_spots #そのユーザーがいいねした投稿

    end
    
    def mypage
        @user = current_user
        @spots = @user.spots
        render :show
    end

end
