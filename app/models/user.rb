class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  attr_accessor :remember_token
  enum role: [:user, :moderator, :admin]
  has_many :comments, dependent: :destroy
  has_many :borrows, dependent: :destroy

  has_many :active_relationship_user, class_name: RelationshipUser.name, foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_relationship_user, source: :followed
  has_many :passive_relationship_user, class_name: RelationshipUser.name, foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationship_user, source: :follower

  # has_many :active_relationship_author, class_name: RelationshipAuthor.name, foreign_key: "user_f_id", dependent: :destroy
  # has_many :favorite_authorsing, through: :active_relationship_author, source: :author_f

  has_many :favorites
  has_many :favorite_authors, through: :favorites, source: :favorable, source_type: Author.name, dependent: :destroy
  has_many :favorite_books, through: :favorites, source: :favorable, source_type: Book.name, dependent: :destroy

  before_save :email_downcase
  validates :name,  presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :content, length: { maximum: 200 }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  scope :search_user, -> (name) { where("name LIKE ?", "%#{name}%") }

  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated? remember_token
    return false if remember_token.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def feed
    Comment.where("user_id IN (SELECT followed_id FROM relationship_users WHERE follower_id = :user_id) OR user_id = :user_id", user_id: id)
  end

  def follow other_user 
    following << other_user
  end

  def unfollow other_user
    following.delete(other_user)
  end

  def following? other_user
    following.include?(other_user)
  end

  private
  def email_downcase
    self.email = email.downcase
  end
end
