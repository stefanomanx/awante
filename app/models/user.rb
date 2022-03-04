class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, :omniauth_providers => [:spotify]

  #has_one :favourite, dependent: :destroy
  has_one_attached :photo
  has_many :favorites, dependent: :destroy
  has_many :artists, through: :favorites

  def self.from_omniauth(auth)
    user = where(uid: auth.uid).first_or_create do |user|
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.spotify_photo = auth.info.image
      user.name = auth.info.display_name
    end
    user.spotify_token = auth.credentials.refresh_token
    user
  end
end
