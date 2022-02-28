class Artist < ApplicationRecord
  has_many :concerts

  validates :name, presence: true, uniqueness: true
  validates :details, presence: true
end
