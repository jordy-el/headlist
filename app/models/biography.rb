class Biography < ApplicationRecord
  belongs_to :user
  validates :location, format: { with: /[a-zA-Z|\-|\.|,| |']+/ }, allow_nil: true
  validates :hometown, format: { with: /[a-zA-Z|\-|\.|,| |']+/ }, allow_nil: true
  validates :school, format: { with: /[a-zA-Z|\-|\.| |']+/ }, allow_nil: true
  validates :workplace, format: { with: /[a-zA-Z|\-|\.| |']+/ }, allow_nil: true
  validates :website, format: { with: /[a-zA-Z|\-|\.|]+/ }, allow_nil: true
  validates :github, format: { with: /[a-zA-Z|\-|\.|]+/ }, allow_nil: true
end
