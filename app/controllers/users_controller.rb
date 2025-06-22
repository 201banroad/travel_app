class UsersController < ApplicationController
    before_action :authenticate_user!  # ログインしてない人は追い返す

    def show
        @user = current_user  # 今ログインしてる人の情報
        @spots = @user.spots  # このログイン中ユーザーの投稿をまとめて@spotsに入れる
    end

end
