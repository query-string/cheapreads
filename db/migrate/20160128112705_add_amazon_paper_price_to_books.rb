class AddAmazonPaperPriceToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :amazon_paper_price, :float
  end
end
