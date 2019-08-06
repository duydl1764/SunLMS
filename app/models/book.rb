class Book < ApplicationRecord
  belongs_to :author
  belongs_to :category
  belongs_to :publisher

  default_scope -> { order(created_at: :desc) }
  validates :name, presence: true, length: { maximum: 100 },
  					uniqueness: { case_sensitive: false }
  validates :status, presence: true, length: { maximum: 50 }
  validates :content, length: { maximum: 200 }
  validates :pages, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :number_of, numericality: { only_integer: true, greater_than_or_equal_to: 0 }  

  def update_before_destroy_author
    update_attribute(:author_id, 1)
  end

  def update_before_destroy_category
    update_attribute(:category_id, 1)
  end

  def update_before_destroy_publisher
    update_attribute(:publisher_id, 1)
  end

end
