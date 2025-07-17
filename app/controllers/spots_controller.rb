class SpotsController < ApplicationController

    # 一覧ページ
    def index 
        @spots = Spot.all
    end

    #  詳細ページ
    def show
        @spot = Spot.find(params[:id])
    end

    # 新規作成
    def new
        @spot = Spot.new
    end

    # 投稿保存
    def create
        @spot = Spot.new(spot_params)
        @spot.user = current_user if user_signed_in?
        if @spot.save
            redirect_to @spot
        else
            render 'new', status: :unprocessable_entity
        end
    end

    # 編集機能はいらない
    # def edit
    #     @spot = Spot.find(params[:id])
    # end

    
    # def update
    #     @spot = Spot.find(params[:id])
    #     if @spot.update(spot_params) 
    #         redirect_to @spot 
    #     else
    #         render 'edit', status: :unprocessable_entity 
    #     end
    # end

    # 削除
    def destroy
        @spot = Spot.find(params[:id])
        @spot.destroy
        redirect_to spots_path
    end

   
    private 
    # ストロングパラメーター、permitの中の項目だけ許可するたとえば項目をLikeって悪いやつに書き換えられたら保存されない、画像は複数枚OKなので[]配列で許可してる。
    def spot_params
        params.require(:spot).permit(:title, :location, :description, :name, images:[])
    end




end