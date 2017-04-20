class User < ApplicationRecord
  has_secure_password
  has_many :microposts, dependent: :destroy
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :reverse_of_relationship, source: :user
  has_many :favorites, dependent: :destroy
  has_many :favorite_microposts, through: :favorites, source: :micropost

  before_save { self.email.downcase }

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship.present?
  end
  def following?(other_user)
    self.followings.include?(other_user)
  end
  def feed_microposts
    Micropost.where(user_id: self.following_ids + [self.id])
  end
  def like(micropost)
    self.favorites.find_or_create_by(micropost_id: micropost.id)
  end
  def dislike(micropost)
    favorite = self.favorites.find_by(micropost_id: micropost.id)
    favorite.destroy if favorite.present?
  end
  def already_like?(micropost)
    self.favorite_microposts.include?(micropost)
  end
end
