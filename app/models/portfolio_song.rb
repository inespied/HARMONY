class PortfolioSong < ApplicationRecord
  belongs_to :portfolio
  belongs_to :song
end
