class PostItController < ApplicationController
  before_action :authenticate_user!


  def new
    @post_it = PostIt.new
  end

  def create
    @post_it = current_user.post_its.build(post_it_params)
    if @post_it.save
      redirect_to mypage_path, notice: "付箋を追加しました！"
    else
      render :new
    end
  end

  def destroy
    @post_it = current_user.post_its.find(params:[id])
    @post_it.destroy

  end

  private

  def post_it_params
    params.require(:post_it).permit(:content)
  end
end
