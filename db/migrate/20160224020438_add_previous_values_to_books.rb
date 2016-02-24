class AddPreviousValuesToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :previous_average_rating, :float, default: 0
    add_column :books, :previous_amazon_paper_price, :float, default: 0
    add_column :books, :previous_amazon_kindle_price, :float, default: 0
  end
end
