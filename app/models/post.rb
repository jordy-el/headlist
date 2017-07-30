class Post < ApplicationRecord
  has_attached_file :photo, styles: {medium: '500x500#', thumb: '200x200#'}
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/
  validate :photo_or_text
  belongs_to :user
  belongs_to :timeline
  has_many :comments, dependent: :destroy
  before_validation :replace_blank_with_nil
  acts_as_votable

  def photo_or_text
    errors.add(:content, 'cannot be present while photo upload is present') if (photo.file? || description) && content
    errors.add(:content, 'must be present if photo is not') if !(photo.file? || description) && !content
    errors.add(:description, 'must be accompanied by a photo') if !photo.file? && description
  end

  private

  def replace_blank_with_nil
    attributes.each do |key, value|
      self[key] = nil if value == ''
    end
  end
end
