class User < ApplicationRecord
  validates :name,
    presence: true,
    length: { maximum: 20 },
    uniqueness: true        # 他のユーザーと同じ名前はダメ


  validates :profile, length: { maximum: 70 }



  # 改行のバリテーション
  validate :profile_line_limit

  def profile_line_limit
    if profile.present? && profile.lines.count > 4
      errors.add(:profile, "は4行以内にしてください")
    end
  end


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # アソシエーション
  has_many :spots, dependent: :destroy
  has_many :likes, dependent: :destroy
  # has_many :liked_spots, through: :likes, source: :spot
  has_many :post_its, dependent: :destroy



  # アイコン画像の設定
  has_one_attached :avatar
end
