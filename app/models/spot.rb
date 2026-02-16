class Spot < ApplicationRecord
    # タイトル、詳細、写真は必須にするためのバリデーション処理
    validates :title, presence: { message: "タイトルは必須です" },
    length: { maximum: 30, message: "は30文字以内で入力してください" }

    validates :description, presence: { message: "魅力は必須です" },
    length: { maximum: 500, message: "は500文字以内で入力してください" }

    validates :location,
    length: { maximum: 15, message: "は15文字以内で入力してください" }
    validates :images, presence: { message: "写真は必須です" }

    validate :description_line_limit



    validate :images_must_be_images
    validate :images_limit
    validate :images_size_limit

    # 写真の添付設定
    has_many_attached :images

    # アソシエーション
    belongs_to :user, optional: true
    has_many :likes, dependent: :destroy
    # has_many :liked_users, through: :likes, source: :user

    private


  def images_must_be_images
    allowed_types = [ "image/jpeg", "image/png", "image/gif", "image/webp" ]

    images.each do |image|
      if image.content_type.in?([ "image/heic", "image/heif" ])
        errors.add(:images, "HEICファイルは投稿できません。JPEGやPNGをお試しください。")
      elsif !image.content_type.in?(allowed_types)
        errors.add(:images, "対応している画像形式（JPEG、PNG、GIF、WebP）でアップロードしてください。")
      end
    end
  end

  # 画像サイズ制限（10MBまで）
  def images_size_limit
    max_size = 10.megabytes
    images.each do |image|
      if image.blob.byte_size > max_size
        errors.add(:images, "は1枚あたり10MB以下にしてください")
      end
    end
  end


  def description_line_limit
    return if description.blank?

    max_lines = 10
    if description.count("\n") >= max_lines
      errors.add(:description, "は#{max_lines}行以内で入力してください")
    end
  end

  def images_limit
    if images.attached? && images.count > 4
      errors.add(:images, "は4枚以内でアップロードしてください")
    end
  end
end
