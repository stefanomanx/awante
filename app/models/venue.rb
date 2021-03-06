class Venue < ApplicationRecord

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  has_many :concerts
  has_one_attached :photo

  validates :name, presence: true, uniqueness: true
  validates :address, presence: true, uniqueness: true
  # validates :location, presence: true
end
