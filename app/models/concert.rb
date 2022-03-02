class Concert < ApplicationRecord
  belongs_to :artist
  belongs_to :venue
  # has_one_attached :photo

  validates :title, presence: true
  validates :content, presence: true
  validates :date, presence: true
end
