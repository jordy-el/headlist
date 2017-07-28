class Comment < ApplicationRecord
  validates :content, presence: true
  belongs_to :user
  belongs_to :post
  acts_as_votable
end
