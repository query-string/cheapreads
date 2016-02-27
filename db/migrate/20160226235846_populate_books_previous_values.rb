class PopulateBooksPreviousValues < ActiveRecord::Migration[5.0]
  def change
    Book.all.each do |b|
      if b.average_ratings.any?
        last_average_rating     = b.average_ratings.order("id DESC").first.changed_value
        previous_average_rating =  if b.average_ratings.size > 2
          b.average_ratings[b.average_ratings.size - 2].changed_value
        else
          b.average_rating
        end
        b.update(previous_average_rating: previous_average_rating)
      end

      if b.amazon_paper_prices.any?
        last_amazon_paper_price     = b.amazon_paper_prices.order("id DESC").first.changed_value
        previous_amazon_paper_price =  if b.amazon_paper_prices.size > 2
          b.amazon_paper_prices[b.amazon_paper_prices.size - 2].changed_value
        else
          b.amazon_paper_price
        end
        b.update(previous_amazon_paper_price: previous_amazon_paper_price)
      end

      if b.amazon_kindle_prices.any?
        last_amazon_kindle_price     = b.amazon_kindle_prices.order("id DESC").first.changed_value
        previous_amazon_kindle_price =  if b.amazon_kindle_prices.size > 2
          b.amazon_kindle_prices[b.amazon_kindle_prices.size - 1].changed_value
        else
          b.amazon_kindle_price
        end
        b.update(previous_amazon_kindle_price: previous_amazon_kindle_price)
      end
    end
  end
end
