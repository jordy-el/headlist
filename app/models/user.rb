class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :first_name, presence: true, format: { with: /\A[a-zA-Z|\-]+\z/ }
  validates :last_name, presence: true, format: { with: /\A[a-zA-Z|\-]+\z/ }
  validates :date_of_birth, presence: true
  validates :city, presence: true, format: { with: /\A[a-zA-Z|\-|\ ]+\z/ }
end
