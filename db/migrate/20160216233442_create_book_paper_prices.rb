class CreateBookPaperPrices < ActiveRecord::Migration[5.0]
  def change
    create_table :book_paper_prices do |t|
      t.integer :book_id, null: false
      t.float :amazon_paper_price, default: 0

      t.timestamps
    end
    add_index :book_paper_prices, :book_id
  end
end
