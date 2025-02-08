class CreatePortfolios < ActiveRecord::Migration[7.1]
  def change
    create_table :portfolios do |t|
      t.string :title
      t.string :tags
      t.references :user, null: false, foreign_key: true
      t.integer :price_per_day

      t.timestamps
    end
  end
end
