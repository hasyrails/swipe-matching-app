class YoutubeVideo < ApplicationRecord
  belongs_to :user
  enum status: { default: 0, like: 1, dislike: 2 }
end