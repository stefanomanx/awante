class Artist < ApplicationRecord
  has_many :concerts
  # has_one_attached :photo

  validates :name, presence: true#, uniqueness: true
  # validates :details, presence: true
end
