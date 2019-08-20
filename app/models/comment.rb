class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :book
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :content, presence: true, length: { maximum: 500 }
  validates :user_id, presence: true
  validates :book_id, presence: true
  validates :picture, file_size: { less_than_or_equal_to: Settings.size_picture_comment.megabytes }
  # validate :picture_size

  # private
  # def picture_size
  #   if picture.size > Settings.size
  #     errors.add(:picture, t(:text_error))
  #   end
  # end
end
