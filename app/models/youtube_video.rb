class YoutubeVideo < ApplicationRecord
  has_many :favorites
  has_many :users, through: :favorites
  enum status: { default: 0, like: 1, dislike: 2 }
  validates :video_id, uniqueness: true
end
