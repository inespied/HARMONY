Booking.destroy_all
PortfolioSong.destroy_all
Portfolio.destroy_all
Song.destroy_all
User.destroy_all

genres = Portfolio::TAG_OPTIONS
moods = ["Luxurious", "Energetic", "Chill", "Elegant", "Vibrant", "Smooth", "Dynamic", "Refreshing", "Mysterious", "Romantic", "Nostalgic", "Casual", "Playful", "Intense", "Peaceful"]

# Seed pour la table users
user_data = [
    { email: "john.smith@example.com", first_name: "John", last_name: "Smith", description: "Software Developer and Music Enthusiast.",image_path: "app/assets/images/photo1.jpg"},
    { email: "emma.jones@example.com", first_name: "Emma", last_name: "Jones", description: "Professional Photographer and Traveler.",image_path: "app/assets/images/photo_moi.png"},
    { email: "michael.brown@example.com", first_name: "Michael", last_name: "Brown", description: "Guitarist and Music Producer.",image_path: "app/assets/images/photo2.jpg" },
    { email: "lucas.miller@example.com", first_name: "Lucas", last_name: "Miller", description: "Food Blogger and Podcaster.",image_path: "app/assets/images/photo3.jpg" },
    { email: "sophia.davis@example.com", first_name: "Sophia", last_name: "Davis", description: "Visual Artist and Designer.",image_path: "app/assets/images/photo4.jpg" },
    { email: "daniel.garcia@example.com", first_name: "Daniel", last_name: "Garcia", description: "Entrepreneur and Innovator.",image_path: "app/assets/images/photo5.jpg" },
    { email: "olivia.martinez@example.com", first_name: "Olivia", last_name: "Martinez", description: "Yoga Instructor and Wellness Advocate.",image_path: "app/assets/images/photo6.jpg" },
    { email: "noah.rodriguez@example.com", first_name: "Noah", last_name: "Rodriguez", description: "Filmmaker and Music Lover.",image_path: "app/assets/images/photo7.jpg" },
    { email: "isabella.lopez@example.com", first_name: "Isabella", last_name: "Lopez", description: "Marketing Specialist and Content Creator.",image_path: "app/assets/images/photo8.jpg" },
    { email: "jackson.wilson@example.com", first_name: "Jackson", last_name: "Wilson", description: "Freelance Writer and Nature Enthusiast.",image_path: "app/assets/images/photo9.jpg" },
    { email: "ava.moore@example.com", first_name: "Ava", last_name: "Moore", description: "Teacher and Amateur Pianist.",image_path: "app/assets/images/photo10.jpg" },
    { email: "elijah.taylor@example.com", first_name: "Elijah", last_name: "Taylor", description: "Photographer and Digital Artist.",image_path: "app/assets/images/photo11.jpg" },
    { email: "mia.anderson@example.com", first_name: "Mia", last_name: "Anderson", description: "Fashion Blogger and Stylist.",image_path: "app/assets/images/photo12.jpg" },
    { email: "james.thomas@example.com", first_name: "James", last_name: "Thomas", description: "Engineer and Hiking Enthusiast.",image_path: "app/assets/images/photo13.jpg" },
    { email: "chloe.jackson@example.com", first_name: "Chloe", last_name: "Jackson", description: "Musician and Environmental Activist.",image_path: "app/assets/images/photo14.jpg" }
  ]

  user_data.each do |user|
    new_user = User.new(
      email: user[:email],
      password: "password123",
      first_name: user[:first_name],
      last_name: user[:last_name],
      description: user[:description],
    )
    new_user.photo.attach(
      io: File.open(user[:image_path]),
      filename: new_user.first_name,
      content_type: "image/jpg"
    )
    new_user.save!
  end

# Seed pour la table songs
songs = [
    { artist_name: "Adele", song_title: "Hello", duration_in_second: 295, genre: "Pop" },
    { artist_name: "The Beatles", song_title: "Hey Jude", duration_in_second: 431, genre: "Rock" },
    { artist_name: "Billie Eilish", song_title: "Bad Guy", duration_in_second: 194, genre: "Pop" },
    { artist_name: "Ed Sheeran", song_title: "Shape of You", duration_in_second: 233, genre: "Pop" },
    { artist_name: "Drake", song_title: "God's Plan", duration_in_second: 198, genre: "Hip-Hop" },
    { artist_name: "Taylor Swift", song_title: "Shake It Off", duration_in_second: 242, genre: "Pop" },
    { artist_name: "Kendrick Lamar", song_title: "HUMBLE.", duration_in_second: 177, genre: "Hip-Hop" },
    { artist_name: "Beyoncé", song_title: "Single Ladies", duration_in_second: 203, genre: "Pop" },
    { artist_name: "Post Malone", song_title: "Rockstar", duration_in_second: 229, genre: "Hip-Hop" },
    { artist_name: "The Weeknd", song_title: "Blinding Lights", duration_in_second: 200, genre: "Pop" },
    { artist_name: "Lady Gaga", song_title: "Poker Face", duration_in_second: 217, genre: "Pop" },
    { artist_name: "Shawn Mendes", song_title: "Stitches", duration_in_second: 211, genre: "Pop" },
    { artist_name: "Rihanna", song_title: "Umbrella", duration_in_second: 273, genre: "Pop" },
    { artist_name: "Justin Bieber", song_title: "Sorry", duration_in_second: 204, genre: "Pop" },
    { artist_name: "Coldplay", song_title: "Viva La Vida", duration_in_second: 242, genre: "Rock" }
  ]

songs.each do |song|
    Song.create!(
      artist_name: song[:artist_name],
      song_title: song[:song_title],
      duration_in_second: song[:duration_in_second],
      genre: song[:genre]
    )
  end


# Seed des portfolios
photos = Dir["app/assets/images/Portfolio*.jpg"].shuffle # Récupère les chemins des photos disponibles et les mélange

moods.shuffle.each_with_index do |mood, i|
  # Assurez-vous qu'il reste encore des photos disponibles
  break if photos.empty?

  portfolio = Portfolio.new(
  title: "#{mood} Portfolio", # Utilise le mot du mood mélangé
  tags: genres.sample,
  user_id: User.all.sample.id,
  price_per_day: 50 + (i * 10)
  )

  # Utiliser la première photo du tableau, puis la retirer pour qu'elle ne soit pas réutilisée
  photo_path = photos.pop

  portfolio.photo.attach(
  io: File.open(photo_path),
  filename: File.basename(photo_path),
  content_type: "image/jpg"
  )

  portfolio.save!
end

  # Seed pour la table portfolio_songs
  15.times do |i|
    PortfolioSong.find_or_create_by!(
      portfolio_id: Portfolio.all.sample.id,
      song_id: Song.all.sample.id
    )
  end

  # Seed pour la table bookings
  15.times do |i|
    Booking.create!(
      user_id: User.all.sample.id,
      portfolio_id: Portfolio.all.sample.id,
      start_date: "2025-02-14 10:00:00".to_datetime + i.days,
      end_date: "2025-02-14 18:00:00".to_datetime + i.days,
      total_price: (200 + i * 10),
      status: ["declined", "pending", "cancelled","accepted"].sample
    )
  end
