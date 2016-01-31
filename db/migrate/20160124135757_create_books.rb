class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.integer :uid, nil: false
      t.string   :isbn
      t.string   :title, nil: false
      t.text     :description
      t.text     :link

      t.string   :image
      t.string   :average_rating, default: 0
      t.integer  :ratings_count, default: 0
      t.integer  :pages, default: 0
      t.integer  :publication_year, default: 0

      t.datetime :date_added
      t.string   :author_name
      t.string   :author_link
      t.string   :language

      t.string   :amazon_url, default: 0
      t.float    :amazon_paper_price, default: 0
      t.float    :amazon_kindle_price, default: 0

      t.timestamps
    end
    add_index :books, :uid
    add_index :books, :average_rating
    add_index :books, :ratings_count
    add_index :books, :publication_year
    add_index :books, :pages
    add_index :books, :amazon_paper_price
    add_index :books, :amazon_kindle_price
  end
end
