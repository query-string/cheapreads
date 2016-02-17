class PopulateAverageRatingChanges < ActiveRecord::Migration[5.0]
  def change
    Book.all.each { |book| book.average_ratings.create(changed_value: book.average_rating, changed_date: Time.now) }
  end
end
