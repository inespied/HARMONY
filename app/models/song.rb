class Song < ApplicationRecord
  has_many :portfolio_songs
  has_many :portfolios, through: :portfolio_songs
end
