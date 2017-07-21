class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook]
  validates :first_name, presence: true, format: { with: /\A[a-zA-Z|\-]+\z/ }
  validates :last_name, presence: true, format: { with: /\A[a-zA-Z|\-]+\z/ }
  validates :city, format: { with: /\A[a-zA-Z|\-|\ ]+\z/ }, allow_nil: true
  has_one :timeline, dependent: :destroy
  has_many :posts
  after_create { |user| user.timeline = Timeline.create(user: user) }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.name[0...auth.info.name.chars.index(' ')]
      user.last_name = auth.info.name[(auth.info.name.chars.index(' ') + 1)..-1]
      # user.name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end
end
