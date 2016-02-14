class CreateBookRatings < ActiveRecord::Migration[5.0]
  def change
    create_table :book_ratings do |t|
      t.integer :book_id, null: false
      t.string :average_rating, default: 0

      t.timestamps
    end
    add_index :book_ratings, :book_id
  end
end
