class Portfolio < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :portfolio_songs, dependent: :destroy
  has_many :songs, through: :portfolio_songs
  has_one_attached :photo
  TAG_OPTIONS = ["Pop", "Rock", "Hip-Hop", "Jazz", "Classical", "Electronic", "Reggae", "Country", "Blues", "Metal"]

  # Validation pour s'assurer que le tag est inclus dans la liste prédéfinie
  validates :tags, inclusion: { in: TAG_OPTIONS }
end
