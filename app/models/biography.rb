class Biography < ApplicationRecord
  belongs_to :user
  before_save :replace_blank_with_nil

  private

  def replace_blank_with_nil
    attributes.each do |key, value|
      self[key] = nil if value == ''
    end
  end
end
