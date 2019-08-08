class Category < ApplicationRecord
  has_many :books
  before_save ->{ self.name = name.downcase }
  validates :name, presence: true, length: { maximum: 40 }, uniqueness: { case_sensitive: false }
  validates :content, length: { maximum: 200 }
end
