class Concert < ApplicationRecord
  belongs_to :artist
  belongs_to :venue

  validates :title, presence: true
  validates :content, presence: true
  validates :date, presence: true
end
