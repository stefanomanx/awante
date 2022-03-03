class Artist < ApplicationRecord
  has_many :concerts
  has_one_attached :photo
  has_many :favorites
  has_many :users, through: :favorites

  validates :name, presence: true, uniqueness: true
  # validates :details, presence: true
end
