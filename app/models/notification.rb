class Notification < ApplicationRecord
  validates :message, presence: true
  validates :notification_type, presence: true
  belongs_to :user
  before_validation :turn_blank_into_nil
  before_create :set_unseen

  private

  def set_unseen
    self.seen = false
  end

  def turn_blank_into_nil
    attributes.each do |key, value|
      self[key] != "" || self[key] = nil
    end
  end
end
