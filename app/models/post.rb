class Post < ApplicationRecord
  has_attached_file :photo, styles: { medium: "500x500#", thumb: "200x200#" }
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/
  validate :can_have_file_and_description_or_content
  belongs_to :user
  belongs_to :timeline
  before_validation :replace_blank_with_nil

  def can_have_file_and_description_or_content
    errors.add(:content, "cannot be present while photo upload is present") if (photo.file? || description) && content
    errors.add(:content, "must be present if photo is not") if !(photo.file? || description) && !content
    errors.add(:description, "must be accompanied by a photo") if !photo.file? && description
  end

  private

  def replace_blank_with_nil
    attributes.each do |key, value|
      self[key] != "" || self[key] = nil
    end
  end
end
