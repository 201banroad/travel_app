class LikesController < ApplicationController
    # ユーザーがログインしているかどうか
    before_action :authenticate_user!

    # いいねをする処理
    def create
        @spot = Spot.find(params[:spot_id])
        current_user.likes.create(spot: @spot)#ユーザー特定と、スポットIDを特定する処理（カラムに入れる処理）
        redirect_to spot_path(@spot)
    end

    # いいね取り消しの処理
    def destroy
        @spot = Spot.find(params[:spot_id])
        like = current_user.likes.find_by(spot: @spot)
        like.destroy if like
        redirect_to spot_path(@spot)
    end

end
