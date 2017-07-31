class Notification < ApplicationRecord
  validates :message, presence: true
  validates :notification_type, presence: true
  belongs_to :user
  belongs_to :post, optional: true
  before_validation :turn_blank_into_nil
  before_create :set_unseen

  def notification_text
    case self.notification_type.to_sym
    when :friend_request, :friend_accept
      'Friends'
    when :post_reply, :post_like
      'Your post'
    when :timeline_post
      'Your timeline'
    when :comment_like
      'Your comment'
    else
      'Unknown'
    end
  end

  private

  def set_unseen
    self.seen = false
  end

  def turn_blank_into_nil
    attributes.each { |key, value| self[key] = nil if value == '' }
  end
end
