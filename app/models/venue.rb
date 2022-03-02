class Venue < ApplicationRecord
  has_many :concerts
  # has_one_attached :photo

  validates :name, presence: true#, uniqueness: true
  validates :address, presence: true#, uniqueness: true
  # validates :location, presence: true
end
