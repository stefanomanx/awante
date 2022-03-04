class Artist < ApplicationRecord
  has_many :concerts
  has_one_attached :photo
  has_many :favorites
  has_many :users, through: :favorites

  validates :name, presence: true, uniqueness: true
  # validates :details, presence: true

  include PgSearch::Model
  pg_search_scope :search_by_artist,
    against: [ :name ],
    using: {
      tsearch: { prefix: true }
    }
end
