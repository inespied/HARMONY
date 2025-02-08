class CreateSongs < ActiveRecord::Migration[7.1]
  def change
    create_table :songs do |t|
      t.string :artist_name
      t.string :song_title
      t.integer :duration_in_second
      t.string :genre

      t.timestamps
    end
  end
end
