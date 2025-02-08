class CreatePortfolioSongs < ActiveRecord::Migration[7.1]
  def change
    create_table :portfolio_songs do |t|
      t.references :portfolio, null: false, foreign_key: true
      t.references :song, null: false, foreign_key: true

      t.timestamps
    end
  end
end
