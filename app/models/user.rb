class User < ApplicationRecord
  has_many :user_followers
  has_many :followers, through: :user_followers
  has_many :user_followings, class_name: "UserFollower", foreign_key: :follower_id
  has_many :followings, through: :user_followings, source: :user
  has_many :time_tracks
end
