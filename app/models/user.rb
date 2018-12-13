class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :apikeys

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, on: :create
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def github_key
    found = Apikey.find_by(user_id: self.id, host: "github")
    found.key if found
  end

  def friends
    friendships.map do |friendship|
      User.find(friendship.friend_id)
    end
  end

  def bookmarks
    self.videos.joins(:tutorial).select('videos.title, videos.position, tutorials.title AS tutorial_title').order('tutorial_title, position')  
  end
end
