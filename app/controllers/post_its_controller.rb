class PostItsController < ApplicationController
  before_action :authenticate_user!


  def new
    if current_user.post_its.count >= 5
      redirect_to mypage_path, alert: "付箋は5枚までです。先に削除してください。"
      # return #処理ここで抜けるコード
    else
      @post_it = PostIt.new
    end
  end

  def create
    @post_it = current_user.post_its.build(post_it_params)
      if @post_it.save
        redirect_to mypage_path
      else
        render :new
      end
  end

  def destroy
    @post_it = current_user.post_its.find(params[:id])
    @post_it.destroy
    redirect_to mypage_path

  end

  private

  def post_it_params
    params.require(:post_it).permit(:content)
  end
end
