class Spot < ApplicationRecord
    # タイトル、詳細、写真は必須にするためのバリデーション処理
    validates :title, presence: { message: "タイトルは必須です" }
    validates :description, presence: { message: "魅力は必須です" }
    validates :images, presence: { message: "写真は必須です" }
        # 写真何枚でもOKな処理
    has_many_attached :images

    belongs_to :user  # ← この投稿は誰か1人のユーザーに属してるよ
end
# ここはモデル