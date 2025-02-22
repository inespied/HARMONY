class Portfolio < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :portfolio_songs, dependent: :destroy
  has_many :songs, through: :portfolio_songs
  has_one_attached :photo

  TAG_OPTIONS = ["Pop", "Rock", "Hip-Hop", "Jazz", "Classical", "Electronic", "Reggae", "Country", "Blues", "Metal"]

  validates :title, presence: true
  validates :tags, presence: true, inclusion: { in: TAG_OPTIONS }
  validates :photo, presence: true
  validates :price_per_day, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
