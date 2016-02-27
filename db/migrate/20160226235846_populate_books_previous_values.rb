class PopulateBooksPreviousValues < ActiveRecord::Migration[5.0]
  def change
    Book.all.each do |b|
      b.update(previous_average_rating: b.average_ratings.order("id DESC")[b.average_ratings.size - 1].changed_value) if b.average_ratings.size > 1
      b.update(previous_amazon_paper_price: b.amazon_paper_prices.order("id DESC")[b.amazon_paper_prices.size - 1].changed_value) if b.amazon_paper_prices.size > 1
      b.update(previous_amazon_kindle_price: b.amazon_kindle_prices.order("id DESC")[b.amazon_kindle_prices.size - 1].changed_value) if b.amazon_kindle_prices.size > 1
    end
  end
end
