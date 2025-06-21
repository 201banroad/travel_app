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
        if @spot.save
            redirect_to @spot
        else
            render 'new', status: :unprocessable_entity
        end
    end

    # 編集  たとえば /spots/3/edit にアクセスされたとき、edit が呼ばれる。
    def edit
        @spot = Spot.find(params[:id])
    end

    #更新保存
    def update
        @spot = Spot.find(params[:id])
        if @spot.update(spot_params) # 更新する（）内はストロングパラメータ
            redirect_to @spot #DBに登録できた場合は詳細ページに飛ぶ
        else
            render 'edit', status: :unprocessable_entity # 失敗したら編集ページに戻す
        end
    end

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