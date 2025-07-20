class User < ApplicationRecord
  validates :name,
    presence: true,
    length: { maximum: 20 },
    uniqueness: true        # 他のユーザーと同じ名前はダメ


  validates :profile, length: {maximum: 100}



  # 改行のバリテーション
  validate :profile_line_limit

  def profile_line_limit
    if profile.present? && profile.lines.count > 4
      errors.add(:profile, "は4行以内にしてください")
    end
  end

    
# 同じmailでは登録できないように
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :spots # ← ユーザーは投稿をたくさん持ってるよ

  # ユーザーを削除したときに、その人の投稿も全部一緒に削除される
  has_many :spots, dependent: :destroy
  # これは付箋
  has_many :post_its, dependent: :destroy


  # いいねの設定
  has_many :likes, dependent: :destroy
  has_many :liked_spots, through: :likes, source: :spot


  # アイコン画像の設定
  has_one_attached :avatar

 
end
