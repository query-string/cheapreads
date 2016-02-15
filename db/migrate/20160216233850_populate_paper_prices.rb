class PopulatePaperPrices < ActiveRecord::Migration[5.0]
  def change
    Book.all.each { |book| book.book_paper_prices.create(amazon_paper_price: book.amazon_paper_price) }
  end
end
