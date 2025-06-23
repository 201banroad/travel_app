class User < ApplicationRecord
  validates :name,
    presence: true,
    length: { maximum: 13 }, # 13文字以内
    uniqueness: true        # 他のユーザーと同じ名前はダメ

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :spots # ← ユーザーは投稿をたくさん持ってるよ

  # ユーザーを削除したときに、その人の投稿も全部一緒に削除される
  has_many :spots, dependent: :destroy

  # いいねの設定
  has_many :likes, dependent: :destroy
  has_many :liked_spots, through: :likes, source: :spot

 
end
