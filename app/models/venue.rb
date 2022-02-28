class Venue < ApplicationRecord
  has_many :concerts

  validates :name, presence: true
  validates :address, presence: true
  validates :location, presence: true
end
