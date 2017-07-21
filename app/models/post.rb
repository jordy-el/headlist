class Post < ApplicationRecord
  belongs_to :user
  belongs_to :timeline
  validates :content, presence: true
end
