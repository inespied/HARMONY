# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

genres = ["Pop", "Rock", "Hip-Hop", "Jazz", "Classical", "Electronic", "Reggae", "Country", "Blues", "Metal"]

1000.times do
  Song.create!(
    artist_name: Faker::Music.band,
    song_title: Faker::Music::RockBand.song,
    duration_in_second: rand(120..480), # Durée entre 2 min et 8 min
    genre: genres.sample
  )
end

puts "✅ 1000 chansons ont été ajoutées à la base de données !"
