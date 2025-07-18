class PostIt < ApplicationRecord
  belongs_to :user

  validates :content, presence: true, length: { maximum: 100 }

  validate :line_limit

  private

  def line_limit
    if content.present? && content.lines.count > 5
      errors.add(:content, "は5行以内にしてください")
    end
  end


end
