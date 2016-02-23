class PopulateBooksAverageRating < ActiveRecord::Migration[5.0]
  def change
    Book.all.each { |b| b.update(average_rating: b.average_ratings.order("id DESC").first.changed_value) }
  end
end
