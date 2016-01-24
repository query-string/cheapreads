class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.integer :uid, nil: false
      t.string :isbn
      t.string :title, nil: false
      t.text :link
      t.text :description
      t.string :average_rating
      t.integer :ratings_count
      t.string :image
      t.integer :publication_year
      t.datetime :date_added
      t.string :author_name
      t.string :author_link

      t.timestamps
    end
    add_index :books, :uid
    add_index :books, :title
    add_index :books, :average_rating
    add_index :books, :ratings_count
    add_index :books, :publication_year
  end
end
