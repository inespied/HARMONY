class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :portfolio, null: false, foreign_key: true
      t.datetime :start_date
      t.datetime :end_date
      t.integer :total_price
      t.string :status

      t.timestamps
    end
  end
end
