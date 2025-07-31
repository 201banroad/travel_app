class Spot < ApplicationRecord
    # タイトル、詳細、写真は必須にするためのバリデーション処理
    validates :title, presence: { message: "タイトルは必須です" },
    length: { maximum: 30, message: "は30文字以内で入力してください" }

    validates :description, presence: { message: "魅力は必須です" },
    length: { maximum: 700, message: "は700文字以内で入力してください" }

    validates :location,
    length: { maximum: 15, message: "は15文字以内で入力してください" }
    validates :images, presence: { message: "写真は必須です" }

    validate :description_line_limit



    # 画像以外投稿できないバリテーション
    validate :images_must_be_images

        # 写真何枚でもOKな処理
    has_many_attached :images

    belongs_to :user, optional: true
    # いいねの設定
    has_many :likes, dependent: :destroy
    has_many :liked_users, through: :likes, source: :user

    private

  def images_must_be_images
    images.each do |image|
      unless image.content_type.starts_with?("image/")
        errors.add(:images, "は画像ファイルのみアップロードできます")
      end
    end
  end


  def description_line_limit
    return if description.blank?

    max_lines = 20
    if description.count("\n") >= max_lines
      errors.add(:description, "は#{max_lines}行以内で入力してください")
    end
  end

end
# ここはモデル