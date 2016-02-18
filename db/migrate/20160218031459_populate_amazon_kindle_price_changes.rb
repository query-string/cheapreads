class PopulateAmazonKindlePriceChanges < ActiveRecord::Migration[5.0]
  def change
    Book.all.each { |book| book.amazon_kindle_prices.create(changed_value: book.amazon_kindle_price, changed_date: book.updated_at) }
  end
end
