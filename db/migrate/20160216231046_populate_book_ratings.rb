class PopulateBookRatings < ActiveRecord::Migration[5.0]
  def change
    Book.all.each { |book| book.book_ratings.create(average_rating: book.average_rating) }
  end
end
